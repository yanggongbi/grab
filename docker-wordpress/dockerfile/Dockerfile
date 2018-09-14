FROM wordpress:latest

# Add sudo in order to run wp-cli as the www-data user
RUN apt-get update && apt-get install -y sudo less

# Add WP-CLI
RUN curl -sS -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli-nightly.phar -o /usr/local/bin/wp-cli.phar

# http://axiac.ro/blog/sh-1-t-not-found/
RUN sed -i 's/;sendmail_path.*/sendmail_path=sendmail -t -i/' /usr/local/etc/php/php.ini-production

# Add WP-CLI wrapper
COPY wp.sh /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp-cli.phar /usr/local/bin/wp

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
