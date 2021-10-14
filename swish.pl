/* guess.pl 
 *  
 * Animal guessing game.
 *
 * Author:
 * Date:
 *
 * start with ?- go.     
*/

go :- nl,
      write('Think of a famous computer scientist and I will guess who it is.'),
      nl,
      write('Pick between Ada Lovelace, Grace Hopper, John McCarthy, and Charles Babbage'),
      nl,
      write('Please answer yes or no to the following questions:'),
      nl, nl,
      guess(ComputerScientist),
      write('The computer scientist is '),
      write(ComputerScientist),
      nl,
      undo.

/* hypotheses to be tested */
guess(ada_lovelace )   :- ada_lovelace , !.
guess(grace_hopper) :- grace_hopper, !.
guess(john_mcCarthy)   :- john_mcCarthy, !.
guess(charles_babbage)   :- charles_babbage, !.
guess(unknown).             /* no diagnosis */

/* animal identification rules */
ada_lovelace :- female, 
         died_before_1900s, 
         first_programmer,
         verify(computing_bernoulli_number).
grace_hopper :- female, 
           not(died_before_1900s),
    		not(first_programmer),
          	verify(univac).
john_mcCarthy :- not(female), 
           not(died_before_1900s),
    		not(first_programmer),
         verify(lisp).
charles_babbage :- not(female), 
         died_before_1900s, 
    		not(first_programmer),
         verify(analyrtical_engine).


/* classification rules */
female    :- verify(female).
died_before_1900s :- verify(death_date_before_1900s).
first_programmer :- verify(first_programmer).


/* how to ask questions */
ask(Question) :-
    write('Is the Computer Scientist a '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
      assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.

/* How to verify something */
verify(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.

