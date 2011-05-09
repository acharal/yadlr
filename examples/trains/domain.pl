
%:- consult( '../aleph_dlsettings.pl' ).

:- declare_concept( train ),
	declare_concept( car ),
	declare_concept( load ),
	declare_concept( load_state ),
	declare_concept( station ).


:- add_to_concept( train,      [(t1,0.88), (t2,0.9), (t3,0.8), (t4,1.0)] ).
:- add_to_concept( car,        [(c11,0.9), (c21,0.95), (c22,0.8), (c31,0.8), (c41,0.9), (c42,1.0)] ).
:- add_to_concept( load,       [(l311,1.0), (l312,1.0), (l411,1.0), (l412,1.0), (l421,0.9), (l422,0.8)] ).
:- add_to_concept( load_state, [(gas,1.0),(liquid,1.0),(solid,1.0)] ).
:- add_to_concept( station,    [(st1,1.0),(st2,1.0)] ).


:-      declare_relation( has_car,   train, car),
	declare_relation( has_load,  car,   load),
	declare_relation( has_state, load,  load_state).

:-      add_to_relation( has_car, t1, [(c11,0.9)]).

:-      add_to_relation( has_car, t2, [(c21,0.3),(c22,0.9)] ).

:-      add_to_relation( has_car,  t3,  [(c31,0.9)] ),
	add_to_relation( has_load, c31, [(l311,1.0),(l312,1.0)] ).

:-      add_to_relation( has_car,  t4,  [(c41,0.9),(c42,0.88)] ),
	add_to_relation( has_load, c41, [(l411,1.0),(l412,1.0)] ),
	add_to_relation( has_load, c42, [(l421,1.0),(l422,1.0)] ).

:-      add_to_relation( has_state, l411, [(gas,0.55)] ),
	add_to_relation( has_state, l412, [(solid,0.8)] ),
	add_to_relation( has_state, l311, [(solid,0.8)] ),
	add_to_relation( has_state, l312, [(liquid,0.9)] ),
	add_to_relation( has_state, l421, [(liquid,0.87)] ),
	add_to_relation( has_state, l422, [(gas,0.5)] ).

