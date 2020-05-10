;/*
;	Hacks to match MacOS (most recent first):
;
;	<Sys7.1>	  8/3/92	Elliot make this change
;				  9/2/94	SuperMario ROM source dump (header preserved below)
;*/

	ComponentDispatch (CallComponent , ComponentResult , 0);
	ComponentDispatch (RegisterComponent , Component , 1);
	ComponentDispatch (UnregisterComponent , OSErr , 2);
	ComponentDispatch (CountComponents , long , 3);
	ComponentDispatch (FindNextComponent , Component , 4);
	ComponentDispatch (GetComponentInfo , OSErr , 5);
	ComponentDispatch (GetComponentListModSeed , long , 6);
	ComponentDispatch (OpenComponent , ComponentInstance , 7);
	ComponentDispatch (CloseComponent , OSErr , 8);
	ComponentDispatch (DestroyComponent , OSErr , 9);
	ComponentDispatch (GetComponentInstanceError , OSErr , 10);
	ComponentDispatch (SetComponentInstanceError , void , 11);
	ComponentDispatch (GetComponentInstanceStorage , Handle , 12);
	ComponentDispatch (SetComponentInstanceStorage , void , 13);
	ComponentDispatch (GetComponentInstanceA5 , long , 14);
	ComponentDispatch (SetComponentInstanceA5 , void , 15);
	ComponentDispatch (GetComponentRefcon , long , 16);
	ComponentDispatch (SetComponentRefcon , void , 17);
	ComponentDispatch (RegisterComponentResource , Component , 18);
	ComponentDispatch (CountComponentInstances , long , 19);
	ComponentDispatch (RegisterComponentResourceFile , long , 20);
	ComponentDispatch (OpenComponentResFile , OSErr , 21);
	ComponentDispatch (CleanUpApplicationComponents , void , 22);
	ComponentDispatch (InitComponentManager , void , 23);
	ComponentDispatch (CloseComponentResFile , OSErr , 24);
	ComponentDispatch (ComponentManagerVersion , long , 25);
	ComponentDispatch (xGetComponentParent , long , -26);
	ComponentDispatch (xSetComponentParent , void , -27);
	ComponentDispatch (CaptureComponent , Component , 28);
	ComponentDispatch (UncaptureComponent , OSErr , 29);
	ComponentDispatch (SetDefaultComponent , OSErr , 30);
	ComponentDispatch (LoadComponent , long , 31);
	ComponentDispatch (UnloadComponent , OSErr , 32);
	ComponentDispatch (OpenDefaultComponent , ComponentInstance , 33);
	ComponentDispatch (ComponentSearch , void , 34);
