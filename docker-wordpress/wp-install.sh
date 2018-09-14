#!/bin/bash

function read_input() {
  echo -n "Enter the URL (use IP if you do not have one) and press [ENTER]: "
  read url
  echo -n "Enter the title and press [ENTER]: "
  read title
  echo -n "Enter the admin user name and press [ENTER]: "
  read admin_user 
  echo -n "Enter the admin password and press [ENTER]: "
  read admin_password
  echo -n "Enter the admin email and press [ENTER]: "
  read admin_email
}

function confirm() {
  if [ -z "${url}" ] || [ -z "${title}" ] || [ -z "${admin_user}" ] || [ -z "${admin_password}" ] || [ -z "${admin_email}" ]; then
    echo "there is emtpy var, exit..."
    exit 1
  else
    echo -ne "---\nurl: ${url}\ntitle: ${title}\nuser: ${admin_user}\npassword: ${admin_password}\nemail: ${admin_email}\n---\n"
  fi
}

function install() {
  echo "Starting install wordpress..."
  sleep 10 
  docker exec wordpress_app /usr/local/bin/wp core install \
    --path=/var/www/html \
    --url="http://$url" \
    --title="$title" \
    --admin_user="$admin_user" \
    --admin_password="$admin_password" \
    --admin_email="$admin_email"
}

read_input
confirm
install
