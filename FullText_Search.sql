#Example of FullText Search
create database School;
use School;

#first create a table
create table Student(
Id int auto_increment,
Name varchar(50) not null,
Subject varchar(50) not null,
Age int not null,
Notes varchar(500) not null,
check(Age >=18 and Age <=50),
primary key(Id));

#second insert records into the table
insert into Student
 values(1,'tester','Automation',18, 'The quick test done fox jumps over the lazy dog is an English-language pangram – a sentence that contains all the letters of the alphabet'),
       (2,'tester1','Automation',18, 'The quick brown fox test over the lazy dog is an English-language pangram – a sentence that contains all the letters of the alphabet'),
       (3,'tester2','Automation',18, 'The quick brown fox jumps over the test done dog is an English-language pangram – a sentence that contains all the letters of the alphabet'),
       (4,'tester3','Automation',18, 'The quick brown fox jumps over the lazy dog is an English-language pangram – a test over that contains all the letters of the alphabet'),
       (5,'tester4','Automation',18, 'The quick brown fox jumps over the lazy dog is an English-language pangram – a sentence that test done all the letters of the alphabet');
       
 #get all records
 select * from Student;

#add fulltext index
alter table Student
add fulltext(Name,Subject,Notes);

#show Indexes
show indexes from Student;

#natural-language full-text searches
select 
  Name,
  Notes 
from Student  
where 
  Match(Name,Subject,Notes)
  Against('test,Over' IN NATURAL LANGUAGE MODE); #by default this is in IN NATURAL LANGUAGE MODE

#Boolean full-text searches
select
  Name,
  Notes 
FROM Student
WHERE 
    MATCH(Name,Subject,Notes) 
    AGAINST('test -done' IN BOOLEAN MODE );

#Query Expansion
select
  Name,
  Notes 
FROM Student
WHERE 
    MATCH(Name,Subject,Notes) 
    AGAINST('test' WITH QUERY EXPANSION )