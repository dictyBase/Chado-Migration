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
	+ carton install
	+ `carton exec <command>`
	All the dependencies will be served from a local directory managed by carton. For details visit [https://metacpan.org/module/Carton](https://metacpan.org/module/Carton)

#### Build

```shell
perl -Ilocal/lib/perl5 Build.PL --dsn 'dbi:Oracle:host=<host>;sid=<sid>' --user '<user>' --password '<pass>' --version '0.058'
```

OR (if you installed dependencies using Carton)

```shell
carton exec -- perl Build.PL --dsn 'dbi:Oracle:host=<host>;sid=<sid>' --user <user> --password <pass> --version '0.058'
```

#### Patch
* Add

	```
	./Build add_patch <patch_name>
	```

* Run

	```
	./Build run_patch <patch_name>.pl --release release-2-20
	```
	

