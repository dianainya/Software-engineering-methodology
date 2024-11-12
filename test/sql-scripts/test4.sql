-- Test 4: Удаление данных из platform_prisoner
DELETE FROM platform_prisoner
WHERE first_prisoner IN (SELECT id FROM prisoner)
   OR second_prisoner IN (SELECT id FROM prisoner);

DO
$$
    DECLARE
rows_deleted integer := 0;
BEGIN
SELECT COUNT(*) INTO rows_deleted FROM platform_prisoner
WHERE first_prisoner = 'f5e61491-6bcb-4707-8a74-0c3523bd0be6'
   OR second_prisoner = 'f5e61491-6bcb-4707-8a74-0c3523bd0be6';

IF rows_deleted = 0 THEN
            RAISE NOTICE 'Test 4 - Deletion of platform_prisoner records: OK';
ELSE
            RAISE NOTICE 'Test 4 - Deletion of platform_prisoner records: FAILED';
END IF;
END
$$;