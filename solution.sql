SELECT 
    client_id
FROM
    bank.client
WHERE
    district_id = 1
LIMIT 5;


SELECT 
    MAX(client_id)
FROM
    bank.client
WHERE
    district_id = 72;

SELECT 
    amount
FROM
    bank.loan
ORDER BY amount
LIMIT 3;

SELECT DISTINCT
    status
FROM
    bank.loan
ORDER BY status ASC;

SELECT 
    loan_id
FROM
    bank.loan
WHERE
    payments = (SELECT 
            MAX(payments)
        FROM
            loan);

SELECT 
    account_id, amount
FROM
    bank.loan
ORDER BY account_id
LIMIT 5;


SELECT 
    account_id, amount, duration
FROM
    bank.loan
WHERE
    duration = 60
ORDER BY amount , account_id DESC
LIMIT 5;


SELECT DISTINCT
    k_symbol
FROM
    bank.`order`
WHERE
    NOT k_symbol = ' ';

SELECT 
    order_id
FROM
    bank.`order`
WHERE
    account_id = 34;


SELECT DISTINCT
    account_id
FROM
    bank.`order`
WHERE
    order_id >= 29540 AND order_id <= 29560;


SELECT DISTINCT
    amount
FROM
    bank.`order`
WHERE
    account_to = 30067122;



SELECT 
    trans_id, date, type, amount
FROM
    bank.trans
WHERE
    account_id = 793
ORDER BY date DESC
LIMIT 10;


SELECT 
    district_id, COUNT(client_id)
FROM
    bank.client
WHERE
    district_id < 10
GROUP BY district_id
ORDER BY district_id ASC;



SELECT 
    type, COUNT(card_id)
FROM
    bank.card
GROUP BY type
ORDER BY COUNT(card_id) DESC;


SELECT 
    account_id, SUM(amount)
FROM
    bank.loan
GROUP BY account_id
ORDER BY SUM(amount) DESC
LIMIT 10;



SELECT 
    date, COUNT(loan_id)
FROM
    bank.loan
WHERE
    date < 930907
GROUP BY date
ORDER BY date DESC;


SELECT 
    date, duration, COUNT(loan_id)
FROM
    bank.loan
WHERE
    date BETWEEN 971201 AND 971231
GROUP BY date , duration
ORDER BY date , duration;


SELECT 
    account_id, type, SUM(amount) AS total_amount
FROM
    bank.trans
WHERE
    account_id = 396
GROUP BY account_id , type
ORDER BY type ASC;


SELECT 
    account_id,
    CASE type
        WHEN type = 'VYDAJ' THEN 'INCOMING'
        WHEN type = 'PRIJEM' THEN 'OUTGOING'
        ELSE ''
    END AS transaction_type,
    FLOOR(SUM(amount)) AS total_amount
FROM
    bank.trans
WHERE
    account_id = 396
GROUP BY account_id , type;



SELECT 
    FLOOR(SUM(amount)) AS outgoing
FROM
    bank.trans
WHERE
    account_id = 396 AND type = 'PRIJEM'
GROUP BY type;


SELECT 
    FLOOR(SUM(amount)) AS incoming
FROM
    bank.trans
WHERE
    account_id = 396 AND type = 'VYDAJ'
GROUP BY type;


SELECT 
    '369' AS account_id,
    outgoing,
    incoming,
    outgoing - incoming AS diff
FROM
    (SELECT 
        (SELECT 
                    FLOOR(SUM(amount))
                FROM
                    bank.trans
                WHERE
                    account_id = 396 AND type = 'PRIJEM'
                GROUP BY type) AS 'outgoing',
            (SELECT 
                    FLOOR(SUM(amount))
                FROM
                    trans
                WHERE
                    account_id = 396 AND type = 'VYDAJ'
                GROUP BY type) AS 'incoming'
    ) AS one_row;



SELECT 
    account_id,
    FLOOR(SUM(CASE
                WHEN type = 'PRIJEM' THEN amount
                WHEN type = 'VYDAJ' THEN - amount
                ELSE 0
            END)) AS Difference
FROM
    bank.trans
GROUP BY account_id
ORDER BY Difference DESC
LIMIT 10;
