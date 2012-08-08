## Chado Migration
Module for chado database migration

### Getting Started

#### Installation
Clone the repository

```shell
git clone git://github.com/dictyBase/Chado-Migration.git
```

#### Dependencies
* Standard way
`cpan .` OR `cpanm --installdeps .`

* Alternate way
	+ Install Carton: `cpanm Carton`
	+ `carton install`
	+ `carton exec <command>`
	All the dependencies will be served from a local directory managed by carton. For details visit [https://metacpan.org/module/Carton](https://metacpan.org/module/Carton)

* Install Modware

	```shell
	curl -O -L -k https://github.com/downloads/dictyBase/Modware/modware-03-22-2012.tar.gz\
	  && carton install modware-03-22-2012.tar.gz \
	    && rm modware-03-22-2012.tar.gz
	```

#### Build

```shell
perl -Ilocal/lib/perl5 Build.PL --dsn 'dbi:Oracle:host=<host>;sid=<sid>' --user '<user>' --password '<pass>' --version '0.058'
```

Just to check if the build went fine
```shell
./Build chado_version_in_db
```

#### Patch
* Add

	```
	./Build add_patch <patch_name>
	```
A template patch will be created. Add the code to the submodule using the variables already defined.

* Run

	```
	./Build run_patch <patch_name>.pl --release release-2-20
	```
	

