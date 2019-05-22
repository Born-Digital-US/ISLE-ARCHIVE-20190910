## What is the documentation narrative?

### Objective
Create the starter page that is printed "evolution" of an ISLE user and their "leveling up" in needs from demo to production system. This should be a modular structure balancing understanding with quickstart style distilled facts. 

* Use cases
  * Demo site
  * Local Development
  * Staging 
  * Production (Public, finished code)
  * Building ISLE / Maintainers

Introduction 
* Demo site  
  * User case: 1st use case, no experience potentially with Islandora, kicking tires on ISLE
  * Requirements
  * Installation on Laptop and associated usage
  * Islandora
  * Use cases  what the demo can and can't do
  * Concepts
    * What is Docker?
    * Use `Demo` `docker-compose.yml` template
  * Configuration  
    * SSLs types (Self-Signed)
    * Domain information

* Local development 
  * User case: 2nd use case, Developing Drupal code, testing objects and Solr schemas
  * Requirements
  * Installation on Laptop and associated usage
  * Workflows
    * Use cases what the local can and can't do
    * Drupal theme development
    * Object and metadata ingest testing
    * Use `development` `docker-compose.yml` template
* Configuration  
  * SSLs types (Self-Signed)
  * Domain information

Level up - Intermediate
* Staging site - 
  * Use case: 3rd use case (Not public, with almost finished code, Fedora data refreshed from Production systems).
  * Requirements
  * Installation on Server and associated usage
  * Introduction to workflows
    * What is git?
    * Differences from demo site
    * Testing on dev / local, pushing to staging, pushing to production
      * Managing Islandora and Drupal code in a repo
      * Managing ISLE configs in a repo
       * Use `Staging` `docker-compose.yml` template
       * Isle updates - images
         * git upstreams
    * ISLE upgrading - pulling images on the system and how to restart a system
  * Specifics to public environments
    * Security
      * Ports
      * Firewalls
      * SSLs types (Let's Encrypt and Commercial)
    * Storage
    * Naming conventions
      * Containers
      * Domains / DNS
      * Directories
    * Host Server maintenance 
      * Package updates       
   * Migrating your current non-ISLE Islandora system
     * Gathering / copying data from non-ISLE production systems
     * Gathering / copying specific non-ISLE production configurations
     * Merging / editing configurations on a local
       * Comparison process to ISLE "stock"
         * Transforms
         * Solr configs
       * Editing ISLE staging template 
       * Flow in your institutional customizations
       * Checking these changes into the ISLE config git repository
     * Cloning to your `Staging` system  
     * Getting copied production data into place on `Staging` system
     * Spinning up system and QC
     * Troubleshooting

Level up - Intermediate
* Production
  * Use case: 4th use case (Public, finished code, main Fedora data)
  * Requirements
  * Installation on Server and associated usage
  * Data and configuration differences from `Staging`
  * New Production concepts and workflows
    * Backups
    * "Data down / code up"
    * Testing on dev, pushing to staging, pushing to production
      * Managing Islandora and Drupal code in a repo
      * Managing ISLE configs in a repo
       * Use `Production` `docker-compose.yml` template
       * Isle updates - images
         * git upstreams
    * ISLE upgrading - pulling images on the system and how to restart a system
    * Scheduling for work related thing
    * Shared work in Islandora - teams
    * Testing code - CI / Behat
  * Specifics to public environments
    * Security
      * Ports
      * Firewalls
      * SSLs types (Let's Encrypt and Commercial)      
    * Storage
    * Naming conventions
      * Containers
      * Domains / DNS
      * Directories
    * Host Server maintenance 
      * Package updates 
   * Migrating your current non-ISLE Islandora system
     * Lessons learned from `Staging` setup
       * Flow in changes and adapt for `Production` specifically
     * Review for `Production`  
       * Gathering / copying data from non-ISLE production systems
       * Gathering / copying specific non-ISLE production configurations
     * Merging / editing configurations on a local
       * Work from `Staging` ISLE config
       * Comparison process to ISLE "stock" as a caution.
         * Transforms
         * Solr configs
       * Editing ISLE staging template 
       * Flow in your institutional customizations
       * Checking these changes into the ISLE config git repository
     * Cloning to your `Production` system  
     * Getting copied production data into place on `Production` system
     * Spinning up system and QC
     * Troubleshooting
     * Cutover from non-ISLE to ISLE process

Level up - Advanced

* ISLE Architecture
  * What is in each container? Tools
  * ISLE internals - components of ISLE 
    * `confd` - dynamic configuration
    * `traefik` - proxy / Docker service communication
    * `s6` - process management
  * Bind-mounting customizations to ISLE
  * Changing values in containers
  * Host interaction
  * Networking
  * Environments
  * Diagrams
* Releases
  * Projects
  * Numbering
  * What is in a release e.g. 1.1, 1.1.1, 1.1.2 etc
* Glossary
  * Cookbooks

* ISLE Maintainers
  * Building ISLE
    * Use case: ISLE Maintainers building images or Power users rolling their own ISLE images. Dev / Beta testing code. High use of CPU, compiling etc.
    * Requirements
    * Installation on Local laptop and associated usage
  * ISLE Feature Development e.g. Phase II etc
  * Dockerhub.com
  * Github.com
  * Issues queue and workflow
  * Code of Conduct
  * Git workflows
  * Role definition and reporting to ICG steering committee
