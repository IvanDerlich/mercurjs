
# mercurjs

## Quick command generators

You can use the following helper scripts to generate ready-to-copy commands based on your .env configuration:

- `n`: prints the npx command to create a new mercurjs project with the correct database connection string from your .env file.
- `p`: prints the psql command to connect to your database using the credentials from your .env file.

Both scripts use the .env file in the current directory by default. Edit the `ENV_DIR` variable inside each script if your .env is in a different folder.

Example usage:

```bash
# Print the npx command
./n
# Print the psql command
./p
```

Copy and paste the output command wherever you need it.

docker exec -it mercurjs-dev bash

npx @mercurjs/cli create my-marketplace --template basic --skip-email --db-connection-string "postgresql://appuser:change_me_strong@localhost:5432/appdb"

npm run dev
