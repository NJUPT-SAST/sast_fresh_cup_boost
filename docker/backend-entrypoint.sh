#!/usr/bin/env sh
READY_CHECK_FILE=/service-ready-check
CLIENT_SECRET=${1}

php artisan migrate --force \
&& echo "migration done!"\
&& rm -rf ${READY_CHECK_FILE}\
&& echo "\$client= Schema::hasTable('oauth_clients') && DB::table('oauth_clients')->where('id',2)->first();\
if(!\$client){\
echo shell_exec('php artisan passport:install');\
}\
echo 'client ready';\
echo DB::table('oauth_clients')->where('id',2)->update(['secret' => '${CLIENT_SECRET}']);\
echo 'CLIENT_SECRET=${CLIENT_SECRET}';
\$admin=User::where('is_admin',1)->first();\
if(!\$admin){\
\$admin = User::create([\
'name' => '${ADMIN_NAME}',\
'email' => '${ADMIN_EMAIL}',\
'password' => Hash::make('${ADMIN_PASSWORD}')\
]);\
\$admin->is_admin=1;\
\$admin->save();\
}\
echo 'ADMIN_NAME=${ADMIN_NAME};ADMIN_EMAIL=${ADMIN_EMAIL};ADMIN_PASSWORD=${ADMIN_PASSWORD}';\
echo 'admin ready';\
file_put_contents('${READY_CHECK_FILE}','1');\
" | php artisan tinker - \
&& test -f ${READY_CHECK_FILE}\
&& php artisan serve --host 0.0.0.0 --port 8000
