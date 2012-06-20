%% front-end for Aleph and prodlr
%% 
%% Author: Angelos Charalambidis <acharal@users.sourceforge.net>
%%         Stasinos Konstantopoulos <stasinos@users.sourceforge.net>
%% Created: 20 Jun 2012
%% 
%% Copyright (C) 2006-2012 Stasinos Konstantopoulos
%% Copyright (C) 2007-2012 Angelos Charalambidis
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License along
%% with this program; if not, write to the Free Software Foundation, Inc.,
%% 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


% yadlr alias
file_search_path(yadlr, X) :- absolute_file_name('.', X).

% aleph alias must resolve to the directory where aleph.pl exists.
% you can download aleph from http://www.comlab.ox.ac.uk/oucl/research/areas/machlearn/Aleph/aleph.pl
file_search_path(aleph, X) :- absolute_file_name('../tools/aleph/', X).


:- use_module(yadlr(prodlr)).

:- consult(aleph(aleph)).

:- assert(('$aleph_sat_terms'(v,v,v,v) :- fail) ).
:- assert(('$aleph_sat_atom'(v,v) :- fail) ).
:- assert(('$aleph_sat_varscopy'(v,v,v):- fail) ).
:- assert((false :- fail)).

aleph_settings :-
   set(nodes, 100000),
   set(i, 3),
   set(depth, 50),
   set(clauselength, 3),
   set(verbosity, 100),
   set(check_useless, true), !.

set_determinations(Pred, []).
set_determinations(Pred, [L|R]) :- 
   determination(Pred, L), 
   set_determinations(Pred, R).

set_predicate(Pred) :-
   Arity = 2,
   functor(Head, Pred, Arity),
   arg(1, Head, +inlist),
   arg(2, Head, -outlist),
   modeh( *, Head),
   findall(X, thread_itemfunctor(X), Determinations),
   set_determinations(Pred/Arity, Determinations).

set_body :-
   mode( *, concept_select(+inlist, #concept_name_or_not, +outlist) ),
   mode( *, forall_select(+inlist, #relation_path, #concept_name_or_not, +outlist) ),
   mode( *, atleast_select(+inlist, #relation_path, #concept_name_or_not, #num, +outlist) ),
   mode( *, atmost_select(+inlist, #relation_path, #concept_name_or_not, #num, +outlist) ),
   mode( *, self_select(+inlist, #relation_path, +outlist) ),
   mode( *, concept_select(+inlist, #concept_name_or_not, -list) ),
   mode( *, forall_select(+inlist, #relation_path, #concept_name_or_not, -list) ),
   mode( *, atleast_select(+inlist, #relation_path, #concept_name_or_not, #num, -list) ),
   mode( *, atmost_select(+inlist, #relation_path, #concept_name_or_not, #num, -list) ),
   mode( *, self_select(+inlist, #relation_path, -list) ),
   mode( *, concept_select(+list, #concept_name_or_not, +outlist) ),
   mode( *, forall_select(+list, #relation_path, #concept_name_or_not, +outlist) ),
   mode( *, atleast_select(+list, #relation_path, #concept_name_or_not, #num, +outlist) ),
   mode( *, atmost_select(+list, #relation_path, #concept_name_or_not, #num, +outlist) ),
   mode( *, self_select(+list, #relation_path, +outlist) ),
   mode( *, concept_select(+list, #concept_name_or_not, -list) ),
   mode( *, forall_select(+list, #relation_path, #concept_name_or_not, -list) ),
   mode( *, atleast_select(+list, #relation_path, #concept_name_or_not, #num, -list) ),
   mode( *, atmost_select(+list, #relation_path, #concept_name_or_not, #num, -list) ),
   mode( *, self_select(+list, #relation_path, -list) ).


config(Pred,reduction) :- 
   set(construct_bottom, reduction),
   set(refine, user),
   aleph_settings,
   set_predicate(Pred),
   set_body.

config(Pred,saturation) :-
   set(construct_bottom, saturation),
   aleph_settings,
   set_predicate(Pred),
   set_body.

init_learn(Pred,Example, Config) :-
   read_all(Example),
   config(Pred,Config).

learn(Pred,Example,Config) :-
   init_learn(Pred,Example, Config), !, 
   induce.

learn(Pred,Example) :- learn(Pred,Example, reduction).

learn(Example) :- learn(target,Example).

%refine(false, target(A, B)) :- !.
refine(false, Head) :-
   '$aleph_global'(modeh, modeh(_,Pred)),
   functor(Pred, Name, Arity),
   functor(Head, Name, Arity),
   Head \== false.

refine((Head:-Body), (Head:-Body2)):- !,
   legitimate_literal(Lit),
   copy_term(Body, Body1),
   append_thread(Lit, Body1, Body2),
   connect_thread((Head:-Body2)).

refine(Head, Clause) :- !,
   refine((Head:-true), Clause).

false :-
   hypothesis(Head, Body, _),
   numbervars((Head:-Body), 0, _),
   Head = target(A, B),
   \+ inout_thread(Body, A, B).

prune((Head:-Body)):-
   numbervars((Head:-Body), 0, _),
   Head = target(A, B),
   \+ inout_thread(Body, A, _), !.
   %fail.

