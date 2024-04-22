-- function for customer orders
select * from transactions

-- procedure for grabbing orders per customer

DELIMITER //
CREATE PROCEDURE ordersPerCustomer(IN cust_id INT)
BEGIN
	select t.customer_id, count(transaction_id), t.movie_id, m.movie_name
	from transactions t
	join movies m
    WHERE t.movie_id = m.movie_id
	AND t.customer_id = cust_id
    GROUP BY t.customer_id, t.movie_id;
    
END //
​
DELIMITER ;

DROP PROCEDURE ordersPerCustomer

CALL ordersPerCustomer(197)
