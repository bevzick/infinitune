DELETE FROM roles
WHERE name IN (
    'listener',
    'artist',
    'distributor',
    'moderator',
    'admin'
);
