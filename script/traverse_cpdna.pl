use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;
use Bio::SeqIO;
use Bio::Tools::Run::RemoteBlast;
use Bio::Phylo::Util::Logger ':simple';

# process command line arguments
my $infile = '../data/NC_007898.gb';
my $taxon  = 49274;
my $outdir;
my $verbosity = WARN;
GetOptions(
    'infile=s' => \$infile,
    'outdir=s' => \$outdir,
    'verbose+' => \$verbosity,
    'taxon=i'  => \$taxon,
);

# instantiate logger
Bio::Phylo::Util::Logger->new(
    '-level' => $verbosity,
    '-class' => 'main',
);

# start reading refseq
INFO "Going to read $infile";
my $seqio = Bio::SeqIO->new(
    '-format' => 'genbank',
    '-file'   => "$infile"
)->next_seq;
my $writer = Bio::SeqIO->new(
    '-format' => 'fasta',
    '-file'   => ">${outdir}/query.fasta",
);
for my $feat ( $seqio->get_SeqFeatures() ) {

    # only considering 'gene' features
    if ( $feat->primary_tag eq 'gene' ) {

        # we want the gene name
        if ( $feat->has_tag('gene') ) {
            my ($name) = $feat->get_tag_values('gene');

#            # no trnas
#            if ( $name !~ /^trn[A-Z]-[ACGU]{3}$/ ) {
                INFO "Preparing query for gene $name";

                # store the sequence
                my $seq = $feat->spliced_seq;
                $seq->id($name);
                $seq->description("");
                $writer->write_seq($seq);
#            }
#            else {
#                DEBUG "Skipping tRNA $name";
#            }
        }
    }
    else {
        DEBUG "Skipping feature " . $feat->primary_tag;
    }
}

# run blast
my $factory = Bio::Tools::Run::RemoteBlast->new(
    '-prog'       => 'blastn',
    '-data'       => 'nr',
    '-readmethod' => 'SearchIO',
);
$Bio::Tools::Run::RemoteBlast::HEADER{'ENTREZ_QUERY'} = "txid${taxon}[Organism:exp] NOT chromosome";
my $r = $factory->submit_blast("${outdir}/query.fasta");
INFO "Submitting query $r";

# start waiting loop
while ( my @rids = $factory->each_rid ) {
    for my $rid ( @rids ) {
        my $rc = $factory->retrieve_blast($rid);

        # result not ready or failed
        if( !ref($rc) ) {
            if( $rc < 0 ) {
                $factory->remove_rid($rid);
            }
            DEBUG "Waiting...";
            sleep 60;
        }

        # have result
        else {
            if ( my $result = $rc->next_result() ) {
                my $name = $result->query_name();
                my $filename = "${outdir}/${name}.out";
                $factory->save_output($filename);
                $factory->remove_rid($rid);
                INFO "Query Name: $name";
                while (my $hit = $result->next_hit) {
                    INFO "\thit name is " . $hit->name;
                    while (my $hsp = $hit->next_hsp) {
                        DEBUG "\t\tscore is " . $hsp->score;
                    }
                }
            }
        }
    }
}



