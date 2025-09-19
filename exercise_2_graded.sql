/* Create a table medication_stock in your Smart Old Age Home database. The table must have the following attributes:
 1. medication_id (integer, primary key)
 2. medication_name (varchar, not null)
 3. quantity (integer, not null)
 Insert some values into the medication_stock table. 
 Practice SQL with the following:
 */

 -- Q!: List all patients name and ages 
SELECT name, age FROM patients;

 -- Q2: List all doctors specializing in 'Cardiology'
SELECT name FROM doctors WHERE specialization = 'Cardiology';

 
 -- Q3: Find all patients that are older than 80
SELECT * FROM patients WHERE age > 80;



-- Q4: List all the patients ordered by their age (youngest first)
SELECT * FROM patients ORDER BY age ASC;



-- Q5: Count the number of doctors in each specialization
SELECT specialization, COUNT(*) FROM doctors GROUP BY specialization;



-- Q6: List patients and their doctors' names
SELECT p.name AS patient, d.name AS doctor
FROM patients p
JOIN doctors d ON p.doctor_id = d.doctor_id;


-- Q7: Show treatments along with patient names and doctor names
SELECT p.name AS patient, d.name AS doctor, t.treatment_type
FROM patients p
JOIN doctors d ON p.doctor_id = d.doctor_id
JOIN treatments t ON p.patient_id = t.patient_id;


-- Q8: Count how many patients each doctor supervises
SELECT d.name AS doctor, COUNT(p.patient_id) AS num_patients
FROM doctors d
LEFT JOIN patients p ON d.doctor_id = p.doctor_id
GROUP BY d.name;


-- Q9: List the average age of patients and display it as average_age
SELECT AVG(age) AS average_age FROM patients;


-- Q10: Find the most common treatment type, and display only that
SELECT treatment_type, COUNT(*) AS count
FROM treatments
GROUP BY treatment_type
ORDER BY count DESC
LIMIT 1;


-- Q11: List patients who are older than the average age of all patients
SELECT name FROM patients WHERE age > (SELECT AVG(age) FROM patients);


-- Q12: List all the doctors who have more than 5 patients
SELECT d.name, COUNT(p.patient_id) AS num_patients
FROM doctors d
LEFT JOIN patients p ON d.doctor_id = p.doctor_id
GROUP BY d.name
HAVING COUNT(p.patient_id) > 5;




-- Q13: List all the treatments that are provided by nurses that work in the morning shift. List patient name as well. 
SELECT p.name AS patient, n.name AS nurse, t.treatment_type
FROM patients p
JOIN treatments t ON p.patient_id = t.patient_id
JOIN nurses n ON t.nurse_id = n.nurse_id
WHERE n.shift = 'Morning';



-- Q14: Find the latest treatment for each patient
SELECT p.name AS patient, t.treatment_type, t.treatment_time
FROM patients p
JOIN treatments t ON p.patient_id = t.patient_id
WHERE t.treatment_time = (
    SELECT MAX(treatment_time)
    FROM treatments
    WHERE patient_id = p.patient_id
);


-- Q15: List all the doctors and average age of their patients
SELECT d.name AS doctor, AVG(p.age) AS avg_age
FROM doctors d
JOIN patients p ON d.doctor_id = p.doctor_id
GROUP BY d.name;


-- Q16: List the names of the doctors who supervise more than 3 patients
SELECT d.name
FROM doctors d
JOIN patients p ON d.doctor_id = p.doctor_id
GROUP BY d.name
HAVING COUNT(p.patient_id) > 3;


-- Q17: List all the patients who have not received any treatments (HINT: Use NOT IN)
SELECT name FROM patients WHERE patient_id NOT IN (
    SELECT patient_id FROM treatments
);



-- Q18: List all the medicines whose stock (quantity) is less than the average stock
SELECT medication_name, quantity
FROM medication_stock
WHERE quantity < (SELECT AVG(quantity) FROM medication_stock);



-- Q19: For each doctor, rank their patients by age
SELECT d.name AS doctor, p.name AS patient, p.age, 
RANK() OVER (PARTITION BY d.doctor_id ORDER BY p.age DESC) AS age_rank
FROM doctors d
JOIN patients p ON d.doctor_id = p.doctor_id;


-- Q20: For each specialization, find the doctor with the oldest patient
SELECT d.specialization, d.name AS doctor, MAX(p.age) AS oldest_patient_age
FROM doctors d
JOIN patients p ON d.doctor_id = p.doctor_id
GROUP BY d.specialization, d.name;





