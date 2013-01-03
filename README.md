# Chado Migration
Module for Chado database migration

## Setup
### Clone the repository

```shell
$_> git clone git://github.com/dictyBase/Chado-Migration.git
```

### Install Dependencies

All the dependencies will be served from a local directory managed by
[carton](https://metacpan.org/module/Carton).

* Install carton using cpanm

	 ```shell
    $_> cpanm -n Carton
   ```

   To install and manage cpanm with __local-lib__ read a short
   [guide](http://dictybase.github.com/perl-setup/index.html)


* Install modules using carton
  From the checkout folder

   ```shell
    $_> carton install
   ```

* Install Modware

	*Deprecated*

	```shell
	$_> curl -O -L -k https://github.com/downloads/dictyBase/Modware/modware-03-22-2012.tar.gz\
	  && carton install modware-03-22-2012.tar.gz \
	    && rm modware-03-22-2012.tar.gz
	```

### Building project

```shell
$_> carton exec -- perl Build.PL --dsn 'dbi:Oracle:host=<host>;sid=<sid>' --user '<user>' --password '<pass>' 
```
  The __Build__ command have to be run for different database or if the chado/schema
  version have changed or if there is any change in  __Build.PL__ file. 

#### Build options

+ **--chado_version:** Version of chado database schema,  default is **1.2**
+ **--version:** Explicitly sets [BCS](https://metacpan.org/module/Bio::Chado::Schema)
                 version.

+ So to explicitly set a particular version
  ```shell
   $_> carton exec -- perl Build.PL --dsn 'dbi:Oracle:host=<host>;sid=<sid>' 
          --user '<user>' --password '<pass>' --version <version>
   ```
   Remember this value will be persisted for all actions which takes a **(--version)**
   argument.

### Bring database under version control

```shell
$_> carton exec -- ./Build install_version
```
By default it will store chado version (1.2) and schema version (0.058) in the database.
However,  to install a particular version ....

```shell
$_> carton exec -- ./Build install_version --version <version>
```

Now to check for version information in database

```shell
$_> carton exec -- ./Build schema_version_in_db
0.058

$_> carton exec -- ./Build chado_version_in_db
1.2
```

## Migration

+ Change the version in __Modware::Chado::Schema__ module.
```perl
our $VERSION = '0.20000';
```
+ Run the Build again with new chado version
```shell
$_> carton exec -- perl Build.PL --dsn 'dbi:Oracle:host=<host>;sid=<sid>' --user '<user>'
                   \ --password '<pass>' --chado_version 1.23
```


+ Create files needed for migration
```shell
$_> carton exec -- ./Build prepare_migration
```
  Creates various database and version specific folders for migration. 

+ Edit files needed for migration
  
  * In this case, look for a folder **db/Oracle/upgrade/0.058-0.20000**. It is a folder for storage
    type(Oracle),  which is going to upgraded from version(0.058) to version(0.20000). The
    folders are created based on version of BCS,  not on the version of chado schema. 

  * Edit the file **001-auto.sql** in the above folder and add SQL statements that will be
    run during the **migration** action(given below).

  * Any  **.pl** file in this folder will also be run during migration. The format of perl script(.pl file) is described
    [here](https://metacpan.org/module/DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator#PERL-SCRIPTS).

  * There will be similar folder structure under **_common**. It will be
    **_common/upgrade/0.058-0.20000**. Any sql or perl script will be run during
    migration,  however it will be independent of any database
    backend(Oracle/Postgresql/SQLite etc).

+ Run migration

  ```shell
  $_> carton exec -- ./Build migrate
  ```

  Migrate to a particular version

  ```shell
  $_> carton exec -- ./Build migrate --version <version>
  ```

## Data Patches
These are perl scripts (*.pl files) that will be run independent of migration process. This
system is created to manipulate data in database without changing its structure.

### Actions for running data patches
Remember each of the action take the (--release) argument,  otherwise each action will
prompt for it.

+ **add_patch:** Create a stub patch file with the given name

  ```shell
   $_> carton exec -- ./Build add_patch add_residue --release r-2-20
  ```

+ **run_patch:** Run a particular patch

  ```shell
  $_> carton exec -- ./Build run_patch 001add_residue.pl
  ```

+ **run_all_patches:** Run all patches

  ```shell
  $_> carton exec -- ./Build run_all_patches
  ```

+ **list_patches:** List of available patches to run
