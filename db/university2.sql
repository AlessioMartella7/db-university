
------------QUERY CON GROUP

-- 1. Contare quanti iscritti ci sono stati ogni anno

SELECT COUNT(*) AS `numero_iscritti`, YEAR(`enrolment_date`) AS `anno_di_iscrizione`
FROM `students`
GROUP BY `anno_di_iscrizione` ;

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT COUNT(*) AS `numero_professori`, `office_address` AS `edificio` 
FROM `teachers` 
GROUP BY `edificio`;


-- 3. Calcolare la media dei voti di ogni appello d'esame

SELECT AVG(`vote`) as `media_voti`, `exam_id` AS `id_appello_esame`
FROM `exam_student` 
GROUP BY `id_appello_esame`;


-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT COUNT(*) AS `corsi_di_laurea`, `department_id` AS `dipartimento`
FROM `degrees`
GROUP BY `department_id`;


-------------QUERY CON JOIN

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT * 
FROM `students` 
JOIN `degrees` ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT * 
FROM `degrees`
INNER JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`
WHERE `degrees`.`level` = 'magistrale' AND `departments`.`name` ='Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT * 
FROM `teachers` 
JOIN `course_teacher` ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses` ON `courses`.`id` = `course_teacher`.`course_id`
WHERE `teachers`.`id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT *
FROM `students` 
JOIN `degrees` ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname`, `students`.`name`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT `courses`.`id` as `id_corso`,
`courses`.`name` AS `nome_corso`,
`degrees`.`name` AS `corso_di_laurea`,
`teachers`.`surname` AS `cognome_professore`,
`teachers`.name AS `nome_professore`
FROM `courses` 
JOIN `degrees` ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`


-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT COUNT(DISTINCT `teachers`.`id`)
FROM `teachers`
JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id`
JOIN `courses` ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees` ON `degrees`.`id` = `courses`.`degree_id`
JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Matematica';

-- 7. BONUS: Selezionare per ogni studente il numero di tentativi sostenutiper ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18. 