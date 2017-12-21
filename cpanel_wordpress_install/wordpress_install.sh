#!/bin/bash
# script to install wordpress
# needs wget or curl installed for downloading the tarball

usage()
{ 
	echo "usage: $(basename "$0") /path/to/install
Database name? -- this is the db name that you want to use for your wordpress install
Database username? -- this is the db username that you want to use for your wordpress install|"
	exit 1
}

install_dir="$1"
curl_exit=$(type curl > /dev/null 2>&1 && echo '0' || echo '1')
wget_exit=$(type wget > /dev/null 2>&1 && echo '0' || echo '1')
wordpress_url='https://wordpress.org/latest.tar.gz'

if [ $UID != 0 ]; then
	 echo 'Please run script as root user'; exit 1
fi

if [ ! -d "$install_dir" ]; then 
	usage
fi

# do the initial download for wordpress latest tarball. they make the link the same instead of making it change based on the version number so this is scriptable. run some checks to see if curl or wget are available.

if [ $curl_exit = 0 ]; then
	curl "$wordpress_url" 1> "$install_dir"/"latest.tar.gz" 2> /dev/null
elif [ $wget_exit = 0 ]; then
	wget -O "$install_dir"/latest.tar.gz "$wordpress_url" 	
else
	echo 'Please install curl or wget to the server and rerun the script'; exit 1
fi

# extract the installation tarball	
tar xzf "$install_dir"/latest.tar.gz -C "$install_dir"

cp "$install_dir"/wordpress/wp-config-sample.php "$install_dir"/wordpress/wp-config.php 

echo 'which username?:'
read username # add a check to check if username is valid cPanel user or not

prefix_user=$(echo ${username:0:7} | sed 's/_$//')
echo $prefix_user | sed 's/$/_/g'

edit_db()
{
echo 'Database name:'
read dbname

echo 'Database username:'
read dbuser

echo 'Database password:'
read dbpass

echo 'Database host:'
read dbhost 

echo 'Database table prefix:'
read db_table_prefix
}

edit_db

# save the database values to the wp-config file
sed -i "s/database_name_here/$prefix_user$dbname/ ; s/username_here/$prefix_user$dbuser/ ; s/password_here/$dbpass/; s/localhost/$dbhost/; s/wp_/$db_table_prefix/" "$install_dir"/wordpress/wp-config.php

# clean up the files we dont need anymore
mv "$install_dir"/wordpress/* "$install_dir"
rm -rf "$install_dir"/wordpress
rm -f "$install_dir"/latest.tar.gz 
chown -R "$username": "$install_dir" 


# the uapi command can be used if the users need to be created in mysql in a cPanel server

# create db user
uapi --user=$username Mysql create_user name=$prefix_user$dbuser password=$dbpass
#mysql -e "Create User $prefix_user$dbuser";

# create db
uapi --user=$username Mysql create_database name=$prefix_user$dbname
#mysql -e "Create Database $dbname";

# grant all privileges on a db for a db user
uapi --user=$username Mysql set_privileges_on_database user=$prefix_user$dbuser database=$prefix_user$dbname privileges=ALL PRIVILEGES
#mysql -e "GRANT ALL ON ${$prefix_user$dbname}.* TO '$dbuser'@'$dbhost'";

# set password
uapi --user=$username Mysql set_password user=$prefix_user$dbuser password=$dbpass
#mysql -e "SET PASSWORD FOR '$prefix_user$dbuser'@'$dbhost' = PASSWORD("$dbpass")";

