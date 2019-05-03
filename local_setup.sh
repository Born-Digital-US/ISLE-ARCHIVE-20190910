docker-compose down -v
rm -rf isle-ingest-samples && rm -rf data/isle-apache-data/isle-ingest-samples
docker-compose pull
docker-compose up -d
say "Docker is up"
sleep 40
set -x && docker exec -it isle-apache-ld bash /utility-scripts/isle_drupal_build_tools/isle_islandora_installer.sh
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_batch"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/all/modules/islandora && git clone https://github.com/mjordan/islandora_batch_with_derivs.git"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_batch_with_derivs"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_book_batch"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_newspaper_batch"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/all/modules/islandora && git clone https://github.com/MarcusBarnes/islandora_compound_batch.git"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_compound_batch"
say "Ingest dependencies are installed"
# docker cp isle-ingest-samples isle-apache-ld:/var/www/html/bd-samples
git clone git@github.com:Born-Digital-US/isle-ingest-samples.git data/isle-apache-data/isle-ingest-samples
docker exec -it isle-apache-ld bash -c "sh /var/www/html/isle-ingest-samples/Batches-by-CModel/ingest_samples.sh /var/www/html" # manually took the newspaper OCR stuff out
say "Samples ingested"
docker exec -it isle-apache-ld bash -c "ln -s /var/www/html/isle-ingest-samples/behat /var/www/html/sites/behat && chown -R islandora:www-data /var/www/html/isle-ingest-samples/behat" # symlink up to the ingest samples location
docker exec -it isle-apache-ld bash -c "mkdir /var/www/html/isle-ingest-samples/behat/debug/logs/"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/behat && composer install"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush dis overlay"
say "Ready for testing" # TODO: are the next restart commands really necessary?
# docker-compose down
# docker-compose up -d
# sleep 300

# service tests first
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/behat && php behat --profile=solr --verbose"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/behat && php behat --profile=traefik --verbose"
# more tk
# apache / islandora tests last
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/behat && php behat --verbose"
say "Testing complete"

# ADDITIONAL COMMAND NOTES
# RUN ONE SCENARIO by name
## php behat --name="Viewing newspaper root"
# RUN THE TESTS FOR SERVICES by targeting each service profile:
## php behat --profile="traefik"
## php behat --profile="solr"
# NOTE that the default profile targets @apache tagged tests
## php behat
#
