    ## -- patch script created by Modware::Chado::Migration module
    use strict;

    sub {
        my ($dh, $dir, $logger ) = @_;

        # - $dh: Modware::Chado::Migration deployment handler object
        #       call $dh->schema to get Bio::Chado::Schema object
        # ** make sure you use transaction for writing to database

        # - $dir: A Path::Class::Dir object representing the data folder.
        # - $logger: A Log::Contextual::WarnLogger object.

        ## -- patch code below
        my $dbhash = {
            'UniProtKB' => {
                'description' => 'Universal Protein Knowledgebase',
                'urlprefix'   => 'http://www.uniprot.org/uniprot/',
                'url'         => 'http://www.uniprot.org'
            },
            'UniProt' => {
                'description' => 'Universal Protein Knowledgebase',
                'urlprefix'   => 'http://www.uniprot.org/uniprot/',
                'url'         => 'http://www.uniprot.org'
            },
            'TrEMBL' => {
                'description' => 'UniProtKB-TrEMBL protein sequence database',
                'urlprefix'   => 'http://www.uniprot.org/uniprot/',
                'url'         => 'http://www.uniprot.org'
            },
            'NCBI_GP' => {
                'description' => 'NCBI GenPept',
                'urlprefix'   => 'http://www.ncbi.nlm.nih.gov/protein/',
                'url'         => 'http://www.ncbi.nlm.nih.gov'
            },
            'NCBI_gi' => {
                'description' => 'NCBI databases',
                'urlprefix' =>
                    'http://www.ncbi.nlm.nih.gov/entrez/viewer.fcgi?val=',
                'url' => 'http://www.ncbi.nlm.nih.gov'
            },
            'JGI_DPUR' => {
                'description' => 'JGI database for Dictyostelium purpureum',
                'urlprefix' =>
                    'http://genome.jgi-psf.org/cgi-bin/dispGeneModel?db=Dicpu1&id=',
                'url' => 'http://genome.jgi-psf.org'
            }, 
            'dictyBaseDP' => {
            	'description' => 'Database for D.discoideum related genomes', 
            	'urlprefix' => 'http://genomes.dictybase.org/id/', 
            	'url' => 'http://genomes.dictybase.org'
            }
            'genbank' => {
            	'description' => 'NIH genetic sequence database', 
            	'urlprefix' => 'http://ncbi.nlm.nih.gov/nuccore/', 
            	'url' => 'http://ncbi.nlm.nih.gov/genbank', 
            	'name' => 'DB:GenBank:nucleotide'
            }
        };

        my $schema = $dh->schema;

        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;

        for my $db ( keys %$dbhash ) {
            my $prefix_name = 'DB:' . $db;
            my $row         = $schema->resultset('General::Db')
                ->find( { name => $prefix_name } );
            if ($row) {
                $row->update( $dbhash->{$db} );
                $logger->info("updated $db entry");
            }
            else {
                $schema->resultset('General::Db')->create(
                    {   name        => $prefix_name,
                        urlprefix   => $dbhash->{$db}->{urlprefix},
                        description => $dbhash->{$db}->{description},
                        url         => $dbhash->{$db}->{url}
                    }
                );
                $logger->info("created $db entry");
            }
        }
        $guard->commit;
    };
