# Suggestions / Sections

## Install ISLE

* We should make a further distinction that these requirements and setups are for HOSTS not ISLE itself.

* Is it `Demo ISLE installation` or `Quickstart guide` or both? We should be consistent in language and link to the README.md of the main ISLE Project and vice-versa.
  * https://github.com/Islandora-Collaboration-Group/ISLE
 
* Remote Server ISLE installation should read something like ISLE project setup.


## Appendencies
* `Installing a Drupal Module with Composer/Persistent Changes` section https://islandora-collaboration-group.github.io/ISLE/appendices/installing-module-with-composer/ 
  * The code snippet is NOT up to date. Remove aliases.

## Troubleshooting

* When starting up ISLE for the first time or 30th time, there will be a period of time 30 seconds to 5 mins depending that `Bad Gateway` displays. This is because the `traefik` / `isle-proxy` container cannot connect to the `apache` service / container yet. Typically there are `confd` commands that set file permissions on `/var/www/html` **EVERYTIME** the apache container is spun up. This will be better handled in a future release of ISLE to minimize the delay. This should be on the main Readme of ISLE aka the quickstart guide and in this area.

## Cookbook Recipes

* This should be several pages not one large monolithic setup.
* Cookbook Recipes is typically for how to use a piece of software to accomplish various unique tasks. This is one big cheatsheet which is great but it isn't a cookbook per se in tech parlance typically.
* Linux not UNIX and these should be characterized as "host" not "Docker" commands.

## Release Notes

* Latest release: 1.1.1
  * Recommend that folks who work on things along with testing be called out positively with links to their profiles in Github?
  * Testing was also performed by Bethany Seeger of Amherst College. She should be credited here please.
  * Let's remove codenames for ISLE please.
  * Isle release 1.1 information is on this page too? Separate please.