
%%
%% declarations
%%


:- declare_concept( 'Train' ),
	declare_concept( 'Car' ),
	declare_concept( 'Load' ),
	declare_concept( 'Wheel' ),
	declare_concept( 'Open' ),
	declare_concept( 'Long' ),
	declare_concept( 'Rectangle' ),
	declare_concept( 'Triangle' ),
	declare_concept( 'Hexagon' ),
	declare_concept( 'Circle' ).

:- declare_relation( hasCar, 'Train', 'Car' ),
	declare_relation( hasLoad, 'Car', 'Load' ),
	declare_relation( hasWheel,'Car', 'Wheel' ),
	declare_relation( inFront, 'Car', 'Car' ).


%%
%% east1 (eastbound)
%%

:- add_to_concept( 'Train', [(east1,0.98)] ).

:- add_to_concept( 'Car',   [(car11,1.0), (car12,1.0), (car13,1.0), (car14,1.0)] ).
:- add_to_concept( 'Open',     [(car11,0.9), (car12,0.1), (car13,0.8), (car14,0.9)] ).
:- add_to_concept( 'Long',     [(car11,0.9), (car12,0.1), (car13,0.8), (car14,0.1)] ).
:- add_to_concept( 'Rectangle',[(car11,0.9), (car12,0.9), (car13,0.8), (car14,0.9)] ).
:- add_to_concept( 'Triangle', [(car11,0.1), (car12,0.1), (car13,0.05),(car14,0.1)] ).
:- add_to_concept( 'Hexagon',  [(car11,0.02),(car12,0.1), (car13,0.2), (car14,0.1)] ).
:- add_to_concept( 'Circle',   [(car11,0.01),(car12,0.1), (car13,0.11),(car14,0.1)] ).

:- add_to_concept( 'Load',  [(load111,1.0), (load112,0.9), (load113,0.9),
			     (load121,1.0), (load131,1.0), (load141,1.0) ] ).
:- add_to_concept( 'Rectangle',[(load111,1.0), (load112,0.9), (load113,0.9),
				(load121,0.1), (load131,0.1), (load141,0.05) ] ).
:- add_to_concept( 'Triangle', [(load111,0.1), (load112,0.2), (load113,0.1),
				(load121,1.0), (load131,0.1), (load141,0.1) ] ).
:- add_to_concept( 'Hexagon',  [(load111,0.1), (load112,0.1), (load113,0.05),
				(load121,0.1), (load131,1.0), (load141,0.01) ] ).
:- add_to_concept( 'Circle',   [(load111,0.1), (load112,0.09),(load113,0.09),
				(load121,0.1), (load131,0.1), (load141,1.0) ] ).

:- add_to_concept( 'Wheel', [(wheel111,1.0), (wheel112,1.0),
			     (wheel121,1.0), (wheel122,1.0),
			     (wheel131,1.0), (wheel132,1.0), (wheel133,1.0),
			     (wheel141,1.0), (wheel142,1.0)] ).

:- add_to_relation( hasCar, east1, [(car11,1.0)] ),
	add_to_relation( inFront, car11, [(car12,1.0)] ),
	add_to_relation( inFront, car12, [(car13,1.0)] ),
	add_to_relation( inFront, car13, [(car14,1.0)] ).

:- add_to_relation( hasLoad,  car11, [ (load111,1.0),  (load112,1.0), (load113,1.0)] ).
:- add_to_relation( hasWheel, car11, [(wheel111,1.0), (wheel112,1.0)] ).
		    
:- add_to_relation( hasLoad,  car12, [(load121,1.0)] ).
:- add_to_relation( hasWheel, car12, [(wheel121,1.0), (wheel122,1.0)] ).

:- add_to_relation( hasLoad,  car13, [(load131,1.0)] ).
:- add_to_relation( hasWheel, car13, [(wheel131,1.0), (wheel132,1.0), (wheel133,1.0)] ).

:- add_to_relation( hasLoad,  car14, [(load141,1.0)] ).
:- add_to_relation( hasWheel, car14, [(wheel141,1.0), (wheel142,1.0)] ).

