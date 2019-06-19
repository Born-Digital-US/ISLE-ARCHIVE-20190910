docker-compose pull
docker-compose up -d
# say "Docker is up"
sleep 40
set -x && docker exec -it isle-apache-ld bash /utility-scripts/isle_drupal_build_tools/isle_islandora_installer.sh
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/all/modules/islandora && git clone https://github.com/Islandora-Labs/islandora_solution_pack_oralhistories.git"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_oralhistories"

docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_batch"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/all/modules/islandora && git clone https://github.com/mjordan/islandora_batch_with_derivs.git"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_batch_with_derivs"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_book_batch"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_newspaper_batch"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/all/modules/islandora && git clone https://github.com/MarcusBarnes/islandora_compound_batch.git"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -y -u 1 en islandora_compound_batch"
# say "Batch Ingest dependencies are installed"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/all/modules/islandora && git clone https://github.com/mnylc/islandora_multi_importer.git"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/all/modules/islandora/islandora_multi_importer &&  composer install"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush en islandora_multi_importer -y"
# say "IMI dependencies installed"

#git clone git@github.com:Born-Digital-US/isle-ingest-samples.git data/isle-apache-data/isle-ingest-samples
git clone git@github.com:Born-Digital-US/isle-behat.git data/isle-apache-data/sites/behat
#docker exec -it isle-apache-ld bash -c "ln -s /var/www/html/isle-ingest-samples/behat /var/www/html/sites/behat && chown -R islandora:www-data /var/www/html/isle-ingest-samples/behat" # symlink up to the ingest samples location
docker exec -it isle-apache-ld bash -c "mkdir /var/www/html/sites/behat/debug/logs/"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/behat && composer install"
docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush dis overlay -y"

# docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -u 1 islandora_batch_with_derivs_preprocess --key_datastream=MODS --scan_target=/var/www/html/isle-ingest-samples/Batches-by-CModel/Collections/files --use_pids=true --namespace=samples --parent=islandora:root --content_models=islandora:collectionCModel"
# docker exec -it isle-apache-ld bash -c "cd /var/www/html && drush -u 1 islandora_batch_ingest"

# docker exec -it isle-apache-ld bash -c "sh /var/www/html/isle-ingest-samples/Batches-by-CModel/ingest_samples.sh /var/www/html" # manually took the newspaper OCR stuff out
# say "Samples ingested"

# service tests first
docker exec -it isle-apache-ld bash -c "cd /var/www/html/ && drush en simpletest -y"
docker exec -it isle-apache-ld bash -c "cp /var/www/html/sites/behat/test_config.ini /var/www/html/sites/all/modules/islandora/islandora/tests/"
docker exec -it isle-apache-ld bash -c "chmod 775 /var/www/html/sites/behat/filter-drupal.xml"
docker exec -it isle-apache-ld bash -c "cd /var/www/html/sites/behat && ./run-isle-tests.sh --run=apache"
# say "Testing complete"
