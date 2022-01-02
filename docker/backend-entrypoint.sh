#!/usr/bin/env sh
READY_CHECK_FILE=/service-ready-check

php artisan migrate --force \
&& echo "migration done!"\
&& rm -rf ${READY_CHECK_FILE}\
&& echo "\$admin=User::where('is_admin',1)->first();\
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
&& php artisan jwt:secret \
&& php artisan config:clear\
&& php artisan route:clear\
&& php artisan cache:clear\
&& (test -f /app/storage/oauth-private.key || php artisan passport:keys)\
&& /usr/local/sbin/php-fpm

# && php artisan optimize --force\
# && php artisan config:cache\
# && php artisan config:clear\
# && php aritsan route:cache\
# && php artisan route:clear\ 