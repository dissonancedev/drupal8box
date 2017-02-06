# Drupal 8 dockerbox

*Drupal 8 dockerbox* is a skeleton that can be used for Drupal 8 development and/or deployment. It includes:
- *front*: Custom docker image running late versions of
  * Nginx
  * PHP-FPM 7.0
  * Memcached
- *db*: MariaDB 10.1.*
- *drush*: Drush image
- *drupal*: Drupal console image

All is neatly packed in a simple file structure:
- `app` - where the Drupal 8 application should be located
- `root` - this folder is mapped into the `/` and can be used to add/overwrite configuration and system files in the front container.

## Requirements

- Docker Engine (>=1.12.0) - [https://docs.docker.com/engine/installation/](Installation instructions)
- Docker Compose (>=1.8.0) - [https://docs.docker.com/compose/install/](Installation instructions)

## How to use Drush and Drupal Console

Drush can be used inside the directory where `docker-compose.yml` is located or any subdirectory in the following form:
`docker-compose exec drush *drush_command*`
`docker-compose exec drupalconsole *drush_command*`

E.g.
`$ docker-compose exec drush si -y myprofile`

> [For Linux users]
> To make it even easier to work with you can add an alias to your user profile ⁽`~/.bash_aliases`):
> `alias drush="docker-compose exec drush"`
> `alias drupal="docker-compose exec drupalconsole"`
