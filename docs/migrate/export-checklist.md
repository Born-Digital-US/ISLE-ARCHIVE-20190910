# Migration Export Checklist

**RECOMMENDATIONS:** 
  * Streamline this page to have more emphasis on path location and realworld names ala the "Quick Start" model.
  * Perhaps state the list first e.g. the table with sample / example pages with explanations at the bottom. If folks are interested, they'll move down the page, otherwise the table at the top is the actionable piece.

## Index

* Checklist overview
  * Apache
    * Notes
  * Fedora
    * Notes
  * Gsearch
  * MySQL
    * Tools for Export
  * Solr
  * Tomcat

### Checklist overview

This section is a checklist of materials to **COPY** from the current running Islandora Production server(s) to the appropriate storage location / directory in order to build your ISLE environment whether it be a `Staging` or `Production` instance.

**Please Note:** _Ubuntu / Debian distribution specific paths are used for all examples file locations below, end users might have different locations for these files HOWEVER the file and directory names etc should be roughly the same._

**Caution**: While the ISLE Project recommends use of export methods or tools such as rsync, scp etc., it assumes that end users are familiar with them and are aware of possible dangers of improperly exporting or copying production data. Ensure adequate backups of any production system(s) are made prior to any attempts. If you are not familiar or are uncomfortable with these processes, it is highly advisable to work with an appropriate IT department.

**Finally also please note:** Instructions from this checklist and the [Migrate to ISLE Environment](../migrate/install-migration.md) may call for you to **COPY** data from your running Islandora environment to a newly created folder of your choice on your ISLE Host Server or on your local machine. You will then work from these copies for future steps.

As a suggested workflow for editing the ISLE configuration, you'll need to copy various configurations down to your local machine and edit or merge contents as directed. (_if necessary_) Due to the potential size of the `Production` data i.e. the Fedora repository data, ideally you will copy that specific production data to a remote ISLE Host server with a larger amount of storage instead of your local machine which may be limited in comparison. In this context of migrating your previously non-ISLE configurations and settings to your new `Staging` and/or `Production` ISLE configuration, actual Fedora repository data isn't required.

Once you've copied everything, you'll edit the new ISLE `Staging` or `Production` configuration `docker-compose.yml` file to add the actual paths to where all the copied and/or merged files and folders now reside.

This custom config should ultimately be checked into a git repository to deploy to the ISLE host server. This should be all you need to do for everything to work with both your copied data and merged production settings. Please review the [Git Workflow](../workflows/gitworkflow.md) page for assistance on suggested. (TO DO - make this page with directions.)

**Recommend:** Having adequate storage space available for the ISLE host server to accommodate a working copy of a production Islandora's associated configurations and data. See recommended storage details from the [Hardware Requirements](../install/host-hardware-requirements.md) page.

---

### Apache

* Contents of the Production Apache webserver `/var/www/html` directory should be copied to a new directory on your ISLE host server in the appropriate storage area for example `yourdomain-data/apache/html/`.

* Copy the following below from the Islandora Production Server(s) to the suggested directories `/current_prod_islandora_config/apache/` or `/yourdomain-data/apache/` on either your local machine or ISLE Host server.

    * `/current_prod_islandora_config/apache/` should be a directory used for configuration files to be merged or edited on your machine

    * `/data/apache/`should be a directory used for apache website code and data copied directly from your production Islandora server to the target ISLE Host server due to size.

This data and these configurations will be used in conjunction with an Apache container.

| Data          | Description                 | Possible Location in current Islandora instance            | Suggested ISLE Path Destination        | Copy location |
| ------------- | -------------               | -------------                 | -------------                          | ------------- |
| html          | Islandora/Drupal Website    | /var/www/                     | yourdomain-data/apache/html/           |  ISLE Host server  |
| settings.php  | Drupal settings.php file    | /var/www/html/sites/default/  | /current_prod_islandora_config/apache/ | local machine |
| php.ini       | PHP configuration file      | /etc/                         | /current_prod_islandora_config/apache/ | local machine |
| yoursite.conf | Apache webserver vhost file | /etc/apache2/sites-enabled/   | /current_prod_islandora_config/apache/ | local machine |


#### Apache Notes

* `/var/www/html`

    * _Entire contents unless size prohibits should be copied to a directory on the remote ISLE host server._

    * _If `html` is not used, then substitute with the appropriate directory for the Islandora / Drupal site_

* `settings.php`

    * _If running multi-sites separate or rename appropriately e.g. multisite2_name_settings.php, multisite3_name_settings.php and so on..._

    * **WARNING:** Be sure to move this file from `yourdomain-data/apache/html/` only and not from your production Islandora site PRIOR to copying.

* `yoursite.conf`

    * Give Apache config paths for Ubuntu here (TO-DO)
    
    * _File will have different name but this should be the enabled Apache vhost file of your production Islandora website._
    * _There may also be a separate vhost that uses SSL and https. Copy that too if available._


---

### Fedora

* Contents of the  production Islandora Fedora `data` directory should be copied to a new directory (for example `yourdomain-data/fedora/data/`) on your new `Staging` or `Production` ISLE host server in the appropriate storage area.

Copy the following below from the Islandora Production Server(s) to the suggested directories `current_prod_islandora_config/fedora/` or `/yourdomain-data/fedora` on either your local machine or ISLE Host server.

This data will be used in conjunction with a Fedora container.  

| File / Directory      | Description                   | Possible Location in current Islandora instance               | Suggested ISLE Path Destination                   | Copy location            |
| -------------         | -------------                 | -------------                    | -------------                                     | -------------            |
| datastreamStore       | Entire Fedora data directory  | /usr/local/fedora/data/          | yourdomain-data/fedora/data/datastreamStore       | ISLE Host server  |
| fedora-xacml-policies | Entire Fedora data directory  | /usr/local/fedora/data/          | yourdomain-data/fedora/data/fedora-xacml-policies | ISLE Host server  |
| objectStore           | Entire Fedora data directory  | /usr/local/fedora/data/          | yourdomain-data/fedora/data/objectStore           | ISLE Host server  |
| fedora.fcfg       | Fedora repository config file | /usr/local/fedora/server/config/ | /current_prod_islandora_config/fedora/ | local machine |
| fedora-users.xml  | Fedora users config file      | /usr/local/fedora/server/config/ | /current_prod_islandora_config/fedora/ | local machine |
| filter-drupal.xml | Fedora Drupal filter file     | /usr/local/fedora/server/config/ | /current_prod_islandora_config/fedora/ | local machine |

#### Fedora Notes

* Do not copy the following directories from the production Islandora fedora `/usr/local/fedora/data` directory.
        * /usr/local/fedora/`data/activemq-data`
        * /usr/local/fedora/`data/resourceIndex`
---

### Gsearch

Copy the following files from the Islandora Production Server(s) to the suggested directory `current_prod_islandora_config/gsearch/` on your local machine.

This data will be used in conjunction with a Fedora container.

| File / Directory | Description   | Possible Location   | Suggested ISLE Path Destination         | Copy location |
| -------------    | ------------- | -------------       | -------------                           | ------------- |
| fedoragsearch.properties | Gsearch config file | /var/lib/tomcat/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/ | /current_prod_islandora_config/gsearch/ | local machine|
| fgsconfig-basic-configForIslandora.properties | Gsearch config file | /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/ | /current_prod_islandora_config/gsearch/ | local machine |
| fgsconfigObjects.properties | Gsearch config file | /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/ | /current_prod_islandora_config/gsearch/ | local machine |
| repository.properties | Gsearch config file | /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/repository/FgsRepos/ | /current_prod_islandora_config/gsearch/ | local machine |
| islandora_transforms | Transformation XSLTs directory | /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/ | /current_prod_islandora_config/gsearch/ | local machine |
| foxmlToSolr.xslt | "top-level" transformational XSLT | /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/ | /current_prod_islandora_config/gsearch/ | local machine |

---

### MySQL

Copy the following below from the Islandora Production Server(s) to the suggested directory `current_prod_islandora_config/mysql/` on your local machine.

This data will be used in conjunction with a MySQL container.

| Data          | Description              | Possible Location  | Suggested COPY Method                   | Suggested ISLE Path Destination       | Copy location            |
| ------------- | -------------            | -------------      | -------------                           | -------------                         | -------------            |
| Databases     | Drupal website databases |  /var/lib/mysql    | CLI, MySQL Workbench or Sequel Pro etc. | /current_prod_islandora_config/mysql/ | local machine |
| my.cnf        | MySQL server config file |  /etc/mysql/my.cnf | rsync / scp                             | /current_prod_islandora_config/mysql/ | local machine |

#### MySQL Notes

* _Drupal website databases can have a multitude of names and conventions. Confer with the appropriate IT departments for your institution's database naming conventions._

* _CLI == Command line_

* _Recommended that the production databases be exported using the `.sql` and `.gz` file formats e.g. `drupal_site_2018.sql.gz` for better compression and minimal storage footprint._

* _If the end user is running multi-sites, there will be additional databases to export._

* _Do not export the `fedora3` database as it will be recreated by the SQL index in later steps of the Migration Guide_

* _If possible, on the production Apache webserver, run `drush cc all` from the command line on the production server in the appropriate sites directory PRIOR to db export(s)_
  * _Otherwise issues can occur on import due to all cache tables being larger than `innodb_log_file_size` allows_

#### MySQL Tools for Export
Here are a few pieces of documentation specific for the tasks above.

**Caution**: While the ISLE Project recommends use of export methods or tools such as mysqldump etc., it assumes that end users are familiar with them and are aware of possible dangers of improperly exporting or copying production data. Ensure adequate backups of any production system(s) are made prior to any attempts. If you are not familiar or are uncomfortable with these processes, it is highly advisable to work with an appropriate IT department.

* [Official MySQL documentation](https://dev.mysql.com/doc/)
    * [mysqldump console utility documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html)
    * [Digital Ocean quick start for mysqldump export](https://www.digitalocean.com/community/tutorials/how-to-import-and-export-databases-in-mysql-or-mariadb)
* [Official MySQL GUI app - Workbench](https://www.mysql.com/products/workbench/) _For Linux, MacOS and Windows_
* [Sequel Pro](https://sequelpro.com/) _MacOS only_

---

##Tomcat

Copy the following below from the Islandora Production Server(s) to the suggested directory `current_prod_islandora_config/tomcat` located on the local machine.

This data will be used in conjunction with the Tomcat service found on a Fedora or SOLR container.

| Data             | Description               | Possible Location                      | Suggested ISLE Path Destination    | Copy location |
| -------------    | -------------             | -------------                          | -------------                      | ------------- |
| tomcat-users.xml | Tomcat server config file | /var/lib/tomcat7/conf/tomcat-users.xml | /current_prod_islandora_config/tomcat/ | local machine |

---

##Solr

Copy the following below from the Islandora Production Server(s) to the suggested directory `current_prod_islandora_config/solr` located on the local machine.

This data will be used in conjunction with a SOLR container.

| Data           | Description                              | Possible Location                                             | Suggested ISLE Path Destination     | Copy location |
| -------------  | -------------                            | -------------                                                 | -------------                       | ------------- |
| schema.xml     | Solr schema file                         | /var/lib/tomcat7/webapps/solr/collection1/conf/schema.xml     | /current_prod_islandora_config/solr | local machine |
| solrconfig.xml | Solr config file                         | /var/lib/tomcat7/webapps/solr/collection1/conf/solrconfig.xml | /current_prod_islandora_config/solr | local machine |
| stopwords.txt  | Solr file for filtering out common words | /var/lib/tomcat7/webapps/solr/collection1/conf/stopwords.txt  | /current_prod_islandora_config/solr | local machine |
