# Migration Merge Checklist

This checklist is to be used during the editing or merging process of the non-ISLE Islandora Production server(s) configuration files to conform to the new ISLE setup. 

This "merge" workflow typically involves:
* copying down the configuration files to an appropriate directory on the your local laptop
* comparing the files to newer ISLE versions
* making edits to the ISLE configurations to reflect potential customization
* Comment the edits in the new ISLE configurations for keeping track of customizations
* checking in the new configurations into a git repository 
* deploying this new setup back to your new ISLE Host Server whether it be `Production` or `Staging`.

---

**Recommendation**: This section needs editing. This is too much and the repeated usage of `yourdomain` is confusing.

The suggested workflow is for endusers to review the Production file(s) first, make note of any settings and then make appropriate edits within the `yourdomain-config` directory to change values, add passwords or usernames etc on your local laptop with the ultimate goal of checking all results into a git repository for deploy later on the ISLE Host server.

The only change is that unless otherwise directed e.g. Apache `html` and Fedora `data`. all changes should be made on the local laptop in the `yourdomain-config` directory.

Please note as per the migration guide instructions the name of this directory shouldn't literally be "yourdomain-config" or "yourdomain-data" so replace "yourdomain" with the name of your intended Islandora site's domain.

While this checklist will attempt to point out most of the merge challenges or pitfalls, you may encounter unique situations depending on the edits and customizations made to your Islandora environment in the past. This is a good place to reach out to the Islandora community for assistance.

## Customization Process

### Signing

In order to avoid issues with ISLE upgrades, it is highly recommended that when making custom edits to any configuration file, to sign the changes. This will help avoid merge conflicts in git, help endusers remember the reasons for the customizations and to help quickly locate said changes.

* Intro to making edits to configuration files 
  * (TO DO) Expand on this please.

* Suggestions on how to "sign" custom edits to configuration files.
  * Who made the edit?
  * When did they make the edit?
  * Why did they make the edit?
    * This should be short 1-2 lines tops as a separate line

**Example 1:**

```bash

code here

### Customization - Institution name - Jane Doe - Date
### This code edit solves the challenge of ...

customized code here

### End Customization

code here

```

**Example 2:**

```bash

code here

<!-- Customization - Institution name - Jane Doe - Date -->
<!-- This code edit solves the challenge of ... -->

customized code here

<!-- End Customization -->

code here

```

* Depending on the configuration file type, comment styles and conventions like `//` or `;` may be employed or enforced. 
  * (TO DO) Make an additional checklist of file types and required commenting convention

* In some cases, some of the configuration files copied from your running production Islandora may have comments (#) in them to help guide endusers to make the appropriate edits e.g. (# end user edit here)

* In most cases, many of the configuration files copied from ISLE repository to `yourdomain-config` will have fake or empty settings in them. Please remove, edit or enter new values as advised.

---

(TO DO) Top-level table of all areas described below. "Quick-start" version.


## Apache

Compare, edit, merge or copy the following from the source directory `current-production-config/apache/` to:

* `yourdomain-config/apache/` on your local laptop.

| Data          | Description                 | Production Data Copy              | Merge, Copy or Edit Location / Destination | Copy location            |
| ------------- | -------------               | -------------                     | -------------                              | -------------            |
| html          | Islandora/Drupal Website    | current-production-config/apache/ | yourdomain-data/apache/                    | Remote ISLE Host server  |
| settings.php  | Drupal settings.php file    | current-production-config/apache/ | yourdomain-config/apache/                  | Local ISLE config laptop |
| site.conf     | Apache webserver vhost file | current-production-config/apache/ | reference file but do not copy             | Local ISLE config laptop |


### Apache Edits

* `html` - endusers will have **copied** this entire directory **instead** to a new directory called `yourdomain-data/apache/html/` on your remote ISLE host server in the appropriate storage area.

* `settings.php` is handled by ISLE `utility-scripts`, this is now a copy of that auto-generated process. (TO DO) Add this copying step to the `Staging` or `Production` deploy.

### Apache - Sites-Enabled

* Make note of the domain name / URL used by Apache
* Make note of what SSL files were previously used. 
  * Does it make sense to continue to use these files or to use Let's Encrypt. 
    * If yes, then copy the SSL files to `/opt/ISLE/config/proxy/ssl-certs`
      * edit the `traefik` .toml file for file locations.
      * (TO DO) - give more concrete paths and examples here

### Apache Optional Edits

| Data          | Description                 | Production Data Copy              | Merge, Copy or Edit Location / Destination | Copy location            |
| ------------- | -------------               | -------------                     | -------------                              | -------------            |
| php.ini       | PHP configuration file      | current-production-config/apache/ | yourdomain-config/apache/                  | Local ISLE config laptop |

* `php.ini` - endusers can make appropriate edits within `yourdomain-config/apache/php.ini` to increase the upload settings, memory etc. as needed. Otherwise leaving the default values should work.

* **Please note:** an additional line will have to be added to the associated `docker-compose.yml` in the Apache `volumes:` section for this edit to work e.g. `- ./apache/php.ini:/etc/php.ini`

| Data          | Description           | Production Data Copy              | Merge, Copy or Edit Location / Destination  | Copy location            |
| ------------- | -------------         | -------------                     | -------------                               | -------------            |
| tmpreaper     | Cronjob for tmpreaper | current-production-config/apache/ | yourdomain-config/apache/                   | Local ISLE config laptop |

* `tmpreaper` - (optional) endusers may want to edit this tmpreaper cron job for different locations and/or times. The `docker-compose.yml` file will need an associated bind-mount for this change.

* **Please note:** an additional line will have to be added to the associated `docker-compose.yml` in the Apache `volumes:` section for this edit to work e.g. `- ./apache/tmpreaper/cron:/etc/cron.d/tmpreaper-cron`


### Apache - SSL-Certs

If need be, please refer to the **SSL certificate** section of the [Glossary](../appendices/glossary.md) for relevant terms to help guide installation.

* Copy your original production SSL certificates for Apache into the `/opt/ISLE/config/proxy/ssl-certs` subdirectory. They will and should have different names than the examples provided below dependent on the ISLE environment you are setting up e.g. (_production, staging, or development_).

    * There can be up to 2 - 3 files involved in this process.

        * 1 x SSL Certificate Key File e.g. `sample-key.pem`
            * This file is required.
            * Please also note that the file extensions can also be: `.key` or `.pem`

        * 1 x SSL Certificate File e.g. `sample.pem`
            * This file is required.
            * Please also note that the file extensions can also be: `.cer`, `.crt` or `.pem`

        * 1 x SSL Certificate Chain File e.g. `sample-interm.pem`
            * This file may be **optional** in some setups but is generally recommended for use by the `apache` container when available.
            * It will not be used by the `proxy` container.
            * Please also note that the file extensions can also be: `.cer`, `.crt` or `.pem`

### Apache - SSL-Certs (multi)

* When creating multiple environments for ISLE, please change all of the file and key names accordingly to reflect the environment e.g. adding (`-prod, -stage, -dev` to file names). Later on, this process will assist in organizing proper filing of files for the `proxy` container and stop any situation where a file gets overwritten or improperly referenced by the wrong environment.

**Example:**

    * 1 x SSL Certificate Key File e.g. `newsite-dev-key.pem`
    * 1 x SSL Certificate File e.g. `newsite-dev.pem`
    * 1 x SSL Certificate Chain File e.g. `newsite-dev-interm.pem`

## Fedora

(OPTIONAL) - One can create new passwords and use default ISLE suggested users. Recommend that one only reviews to ensure that no further customization is required. Typically endusers only have custom `repository-policies` or `fedora-xacml-policies`

Compare, edit, merge or copy the following from the suggested directory `current-production-config/fedora/` to:

* `yourdomain-config/fedora/` on your local laptop.

| Data                  | Description                   | Possible Location                | Merge, Copy or Edit Location / Destination | Copy location |
| -------------         | -------------                 | -------------                    | -------------                              | ------------- |
| fedora-xacml-policies | Entire Fedora data directory  | /usr/local/fedora/data/          | yourdomain-data/fedora/data/fedora-xacml-policies | Remote ISLE Host server  |
| fedora-users.xml      | Fedora users config file      | /usr/local/fedora/server/config/ | yourdomain-config/fedora/ |  Local ISLE config laptop |
| repository-policies   | Fedora Drupal filter file     | /usr/local/fedora/server/config/ | yourdomain-config/fedora/ |  Local ISLE config laptop |

* `fedora/repository-policies` - endusers can edit the files contained within for more granular or customized Fedora user permissions or repository access. These files will need to be bind-mounted in along with the appropriate edits to the appropriate ISLE `docker-compose.yml` file template.

## MySQL

The `mysql` subdirectory contains all specific configurations and overrides necessary for the ISLE mysql image and resulting container to function properly with your changes. This is the Mysql database server that will contain at least two databases, one for the Islandora / Drupal website and the other for the Fedora repository. If you are running Drupal multi-sites, you'll need to create the additional users and database creation scripts.

* (_Optional_) Review Mysql configuration file `my.cnf` and add / flow the customizations to the ISLE.cnf file. Note this file will need to be bind-mounted in. (TO DO) Create a better walkthrough of MySQL tuning.


## Solr

Compare, edit, merge or copy the following from the source directory `current-production-config/solr/` to:

* `yourdomain-config/solr/` on your local laptop.

| Data           | Description               | Possible Location        | Merge, Copy or Edit Location / Destination | Copy location |
| -------------  | -------------             | -------------            | -------------                              | -------------   |
| schema.xml     | Solr index config file    | ../solr/collection1/conf | yourdomain-config/solr/                    | Local ISLE config laptop |
| solrconfig.xml | Solr config file          | ../solr/collection1/conf | yourdomain-config/solr/                    | Local ISLE config laptop |
| stopwords.txt  | solr webserver vhost file | ../solr/collection1/conf | yourdomain-config/solr/                    | Local ISLE config laptop |

### Solr Edits

* `schema.xml`
   * _Usually the first file one configures when setting up a new Solr installation_
   * The schema declares
     * what kinds of fields there are
     * which field should be used as the unique/primary key
     * which fields are required
     * how to index and search each field

* `solrconfig.xml`
   * _The solrconfig.xml file is the configuration file with the most parameters affecting Solr itself._
   * In solrconfig.xml, one can configure the following:
     * request handlers, which process requests to Solr, e.g. requests to add documents to the index or requests to return results for a query
     * processes that "listen" for particular query-related events; listeners can be used to trigger the execution of special code
     * the Request Dispatcher for managing HTTP communications
     * the Admin Web interface
     * parameters related to replication and duplication

* `stopwords.txt`
  * _Using the stopwords.txt file, one can avoid the common words of a language, which do not add a significant value to any search.
  * _For example, a, an, the, you, I, am, and so on. One can specify words to be removed from the Solr search in this file line-by-line._

* Additional Locations:
  * /opt/solr
  * /usr/local/solr
  * /var/lib/tomcat7/webapps/solr
  * /usr/share/tomcat/webapps/solr

(TO DO) - Write up of comparison / merge process to [Discovery Garden basic-solr-config](https://github.com/discoverygarden/basic-solr-config) setup.

### Gsearch Islandora Transforms

(TO DO) - Expand on this with:

* `foxmlToSolr.xslt`
* additional transforms e.g. `RELS-EXT` etc
* custom transform inclusions and how to bind-mount these files