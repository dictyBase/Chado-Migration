## Chado Migration
Module for Chado database migration

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

	*Deprecated*
	```shell
	curl -O -L -k https://github.com/downloads/dictyBase/Modware/modware-03-22-2012.tar.gz\
	  && carton install modware-03-22-2012.tar.gz \
	    && rm modware-03-22-2012.tar.gz
	```

#### Build

```shell
carton exec -- perl Build.PL --dsn 'dbi:Oracle:host=<host>;sid=<sid>' --user '<user>' --password '<pass>' --version '0.058'
```

#### Commands

How to use the different commands can be found in the [wiki](https://github.com/dictyBase/Chado-Migration/wiki/Using-Chado-Migration-commands)
