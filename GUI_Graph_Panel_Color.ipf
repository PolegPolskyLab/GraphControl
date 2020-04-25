#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.

menu "Graph"
	"GraphControl",/q, GraphControlInit()
end

menu "Layout"
	"LayoutControl",/q, LayoutControlInit()
end

menu "AllTracesPopup" 
	"GraphControl",/q,GraphControlInit()
end

menu "TracePopup" 
	"GraphControl",/q,GraphControlInit()
end
macro GraphControlMacro()	
	GraphControlInit()
end
macro LayoutControlMacro()	
	LayoutControlInit()
end
//---------------Layout control----------------
//---------------Layout control----------------
//---------------Layout control----------------
function LayoutControlInit()
 	execute "LayoutControl() "
end

Window LayoutControl() : Panel
	NewPanel /W=(36,60,365,400)/k=1
	SetVariable Left_LC,pos={10.00,22.00},size={80.00,18.00},proc=Left_Right_LC,title="Left"
	SetVariable Left_LC,value= _NUM:125
	SetVariable Top_LC,pos={10.00,42.00},size={80.00,18.00},proc=Left_Right_LC,title="Top"
	SetVariable Top_LC,value= _NUM:10
	Button SetFrame_LC,pos={275.00,63.00},size={40.00,24.00},proc=SetFrame_LC,title="frame"
	Button SetFrame_LC,labelBack=(65535,65535,65535),fColor=(65535,65535,65535)
	Button SetFrame_LC,valueColor=(34952,34952,34952)
	Button MoveLeft_LC,pos={190.00,96.00},size={30.00,30.00},proc=MoveGraphs,title="\\W546"
	Button MoveLeft_LC,fSize=9
	Button MoveRight_LC,pos={270.00,96.00},size={30.00,30.00},proc=MoveGraphs,title="\\W549"
	Button MoveRight_LC,fSize=9
	Button MoveTop_LC,pos={230.00,66.00},size={30.00,30.00},proc=MoveGraphs,title="\\W517"
	Button MoveTop_LC,fSize=9
	Button MoveBottom_LC,pos={230.00,126.00},size={30.00,30.00},proc=MoveGraphs,title="\\W523"
	Button MoveBottom_LC,fSize=9
	GroupBox LayoutGB_LC,pos={100.00,6.00},size={65.00,60.00},title="position  "
	SetVariable PLOT_TOP,pos={38.00,89.00},size={70.00,18.00},proc=LC_PLOTSIZE,title="Top"
	SetVariable PLOT_TOP,valueBackColor=(56576,56576,56576)
	SetVariable PLOT_TOP,limits={-1,1000,10},value= _NUM:0
	SetVariable PLOT_BOTTOM,pos={18.00,131.00},size={90.00,18.00},proc=LC_PLOTSIZE,title="Bottom"
	SetVariable PLOT_BOTTOM,valueBackColor=(56576,56576,56576)
	SetVariable PLOT_BOTTOM,limits={-1,1000,10},value= _NUM:0
	SetVariable PLOT_LEFT,pos={9.00,110.00},size={45.00,18.00},proc=LC_PLOTSIZE
	SetVariable PLOT_LEFT,valueBackColor=(56576,56576,56576)
	SetVariable PLOT_LEFT,limits={-1,1000,10},value= _NUM:0
	SetVariable PLOT_Right,pos={106.00,110.00},size={45.00,18.00},proc=LC_PLOTSIZE
	SetVariable PLOT_Right,valueBackColor=(56576,56576,56576)
	SetVariable PLOT_Right,limits={-1,1000,10},value= _NUM:0
	TitleBox PLOT_LEFTtitle,pos={9.00,96.00},size={20.00,15.00},title="Left",frame=0
	TitleBox PLOT_RIGHTtitle,pos={120.00,96.00},size={28.00,15.00},title="Right"
	TitleBox PLOT_RIGHTtitle,frame=0
	SetVariable PLOT_SIZEW,pos={170.00,22.00},size={95.00,18.00},proc=LC_PLOTSIZE,title="Width"
	SetVariable PLOT_SIZEW,limits={-1,1000,10},value= _NUM:0
	SetVariable PLOT_SIZEH,pos={170.00,42.00},size={95.00,18.00},proc=LC_PLOTSIZE,title="Height"
	SetVariable PLOT_SIZEH,limits={-1,1000,10},value= _NUM:0
	GroupBox PLOT_GBmargins,pos={2.00,70.00},size={163.00,88.00},title="Plot Area"
	GroupBox PLOT_GBmargins,fSize=12
	TitleBox LT_LC,pos={104.00,24.00},size={47.00,15.00},title="(100,100)"
	TitleBox LT_LC,labelBack=(65535,65535,65535),fSize=12,frame=0
	TitleBox RB_LC,pos={166.00,64.00},size={47.00,15.00},title="(100,100)"
	TitleBox RB_LC,labelBack=(65535,65535,65535),fSize=12,frame=0
	SetVariable MOVE_NUM,pos={223.00,102.00},size={45.00,18.00},title=" "
	SetVariable MOVE_NUM,valueBackColor=(56576,56576,56576)
	SetVariable MOVE_NUM,limits={1,1000,1},value= _NUM:5
	Button AlignLeft_LC,pos={190.00,162.00},size={60.00,24.00},proc=AlignGraphs,title="\\Z12align\\Z09\\W546"
	Button AlignLeft_LC,fSize=9
	Button AlignTop_LC1,pos={255.00,162.00},size={60.00,24.00},proc=AlignGraphs,title="\\Z12align\\Z09\\W517"
	Button AlignTop_LC1,fSize=9	
	Button BringFront_LC,pos={275.00,17.00},size={40.00,24.00},proc=BringFront,title="front"
	Button BringFront_LC,labelBack=(65535,65535,65535),fColor=(65535,65535,65535)
	Button PLOT_Layout,pos={275.00,40.00},size={40.00,24.00},proc=GraphControlLayout,title="Layout"
	Button PLOT_Layout,fSize=10,fColor=(61166,61166,61166)
	Button SetGrid_LC,pos={105.00,162.00},size={60.00,24.00},proc=SetGrid,title="set grid"
	Button SetGrid_LC,labelBack=(65535,65535,65535),fColor=(65535,65535,65535)
	SetVariable Grid_LC,pos={3.00,164.00},size={100.00,18.00},proc=LC_PLOTSIZE,title="grid size"
	SetVariable Grid_LC,limits={0,100,1},value= _NUM:5
	Button LCcopy,pos={102.00,41.00},size={40.00,22.00},proc=copy_LC,title="copy"
	Button LCcopy,labelBack=(65535,65535,65535),fColor=(65535,65535,65535)
	Button LC_showG_on_L,pos={28.00,228.00},size={40.00,22.00},proc=LC_G_on_L,title="show"
	Button LC_showG_on_L,labelBack=(65535,65535,65535),fColor=(65535,65535,65535)
	TitleBox LC_G_on_L,pos={10.00,210.00},size={101.00,15.00},title="Graphs: on Layouts"
	TitleBox LC_G_on_L,fSize=12,frame=0
	Button LC_hideG_on_L1,pos={68.00,228.00},size={40.00,22.00},proc=LC_G_on_L,title="hide"
	Button LC_hideG_on_L1,labelBack=(65535,65535,65535),fColor=(65535,65535,65535)
	TitleBox LC_G_noton_L,pos={130.00,210.00},size={79.00,15.00},title="not on Layouts"
	TitleBox LC_G_noton_L,fSize=12,frame=0
	Button LC_shG_not_on_L,pos={128.00,228.00},size={40.00,22.00},proc=LC_G_on_L,title="show"
	Button LC_shG_not_on_L,labelBack=(65535,65535,65535)
	Button LC_shG_not_on_L,fColor=(65535,65535,65535)
	Button LC_hiG_not_on_L2,pos={168.00,228.00},size={40.00,22.00},proc=LC_G_on_L,title="hide"
	Button LC_hiG_not_on_L2,labelBack=(65535,65535,65535)
	Button LC_hiG_not_on_L2,fColor=(65535,65535,65535)
	Button LC_killG_not_on_L2,pos={208.00,228.00},size={40.00,22.00},proc=LC_G_on_L,title="kill"
	Button LC_killG_not_on_L2,labelBack=(65535,65535,65535)
	Button LC_killG_not_on_L2,fColor=(65535,65535,65535)
	Button LC_showEditFromDF,pos={28.00,258.00},size={72.00,22.00},proc=LC_EditfromDF,title="Edit waves"
	Button LC_showEditFromDF,labelBack=(65535,65535,65535)
	Button LC_showEditFromDF,fColor=(65535,65535,65535)
	GroupBox Manage_Windows,pos={2.00,190.00},size={320.00,147.00},title="Manage Windows"
	GroupBox Manage_Windows,fSize=12	
	TitleBox LC_DF,pos={100.00,253.00},size={85.00,15.00},title="datafolder: root:"
	TitleBox LC_DF,fSize=12,frame=0
	TitleBox LC_DF_MEM,pos={100.00,267.00},size={84.00,15.00},title="memory: 17 Mb"
	TitleBox LC_DF_MEM,fSize=12,frame=0
	Button LC_showPlotsFromDF,pos={28.00,285.00},size={180.00,22.00},proc=LC_plotsfromDF,title="Graphs from selected datafolder"
	Button LC_showPlotsFromDF,labelBack=(65535,65535,65535)
	Button LC_showPlotsFromDF,fColor=(65535,65535,65535)
	CheckBox LC_subDF,pos={212.00,289.00},size={104.00,15.00},title="check subfolders"
	CheckBox LC_subDF,value= 1
	CheckBox LC_delete_graphs,pos={212.00,312.00},size={86.00,15.00},title="delete graphs"
	CheckBox LC_delete_graphs,value= 1
	Button LC_Kill_DF,pos={28.00,308.00},size={180.00,22.00},proc=LC_deleteDF_plots,title="Delete datafolder"
	Button LC_Kill_DF,labelBack=(65535,65535,65535),fColor=(65535,65535,65535)
	SetWindow kwTopWin,hook(newLayoutControl)=LayoutControlPanelHook
EndMacro

//---events that happen when layout control panel is activated or resized
function LayoutControlPanelHook(s)
	STRUCT WMWinHookStruct &s	
	if ((s.eventcode==0))			//---activate
		if(strlen(winname(0,4))>0)
			SetWindow $winname(0,4) hook(newLayoutControl)=LayoutControlHook			
		endif
		//---current datafolder
		TitleBox LC_DF title="datafolder: "+getdatafolder(1),win=LayoutControl
		variable memory=round(FindSubFolderSize_LC(getdatafolder(1)))
		if(memory<1000)
			TitleBox LC_DF_MEM title="memory: "+num2str(memory)+" Kb",win=LayoutControl
		else
			TitleBox LC_DF_MEM title="memory: "+num2str(round(memory/(2^10)))+" Mb",win=LayoutControl
		endif
	endif
end
//---the layout is now linked to layoutcontrol panel
function LayoutControlHook(s)
	STRUCT WMWinHookStruct &s
	dowindow LayoutControl
	if (v_flag)
		if ((s.eventcode==5)||(s.eventcode==11))
			execute /p /q "Measure_LC(\"\")"
		endif
	endif
End
//---set the position of active graphs
Function Left_Right_LC(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	if(strlen(winname(0,4))>0)
		string info=layoutinfo("","layout")
		string selected=stringbykey("SELECTED",info,":")
		variable i
		for(i=0;i<itemsinlist(selected,",");i+=1)
			if(stringmatch("left_LC",ctrlName))
				ModifyLayout left($stringfromlist(i,selected,","))=varNum
			else
				ModifyLayout top($stringfromlist(i,selected,","))=varNum
			endif
		endfor
		dowindow /F $winname(0,4)
		dowindow /F LayoutControl
	endif	
End
//---copy pos info to LC
Function copy_LC(ctrlName) : ButtonControl
	String ctrlName
	controlinfo/w=layoutcontrol LT_LC
	variable startpos=strsearch(S_recreation,"(",0),endpos=strsearch(S_recreation,")",0)
	if(endpos-startpos>3)
		SetVariable Left_LC win=layoutcontrol,value= _NUM:str2num(S_recreation[startpos+1,strsearch(S_recreation,",",startpos)-1])
		SetVariable Top_LC win=layoutcontrol,value= _NUM:str2num(S_recreation[strsearch(S_recreation,",",startpos)+1,endpos-1])
	endif
End
//---alight text to grid
Function SetGrid(ctrlName) : ButtonControl
	String ctrlName
	string S_recreation=""
	drawaction /w=$winname(0,4) commands
	if(strlen(S_recreation)>0)
		string items=S_recreation,item,text,command
		drawaction /w=$winname(0,4) delete
		variable line,locx,locy,locR,locB
		controlinfo/w=layoutcontrol Grid_LC
		variable gridsize=v_value
		dowindow/f $winname(0,4)
		for(line=0;line<itemsinlist(items);line+=1)
			item=stringfromlist(line,items)
			if (stringmatch(item,"*item*")==0)
				command=""
				if (stringmatch(item,"*DrawRect*"))
					command="DrawRect"
				endif
				if (stringmatch(item,"*DrawLine*"))
					command="DrawLine"
				endif
				if (stringmatch(item,"*DrawRRect*"))
					command="DrawRRect"
				endif
				if (stringmatch(item,"*DrawOval*"))
					command="DrawOval"
				endif												
				if (stringmatch(item,"*DrawText*"))					
					sscanf item, " DrawText %f,%f,%s ", locx,locy,text
					text=item[strsearch(item,",",strlen(item),1)+1,strlen(item)-1]
					locx=round(locx/gridsize)*gridsize
					locy=round(locy/gridsize)*gridsize
					sprintf item, "DrawText/w=%s %g,%g,%s",winname(0,4), locx,locy,text		
				endif
				if (strlen(command)>0)					
					sscanf item, " "+command+" %f,%f,%f,%f", locx,locy,locR,locB
					locx=round(locx/gridsize)*gridsize
					locy=round(locy/gridsize)*gridsize
					locR=round(locR/gridsize)*gridsize
					locB=round(locB/gridsize)*gridsize
					sprintf item, command+"/w=%s %g,%g,%g,%g",winname(0,4), locx,locy,locR,locB		
				endif
												
				if (stringmatch(item,"*SetDrawEnv*"))
					item=replacestring("SetDrawEnv",item,"SetDrawEnv/w="+winname(0,4))//+",save, ")
					
				endif
				item=replacestring("//",item,"")
				item=replacestring("\r",item,"")
				execute/p/q item
			endif
		endfor
	endif
End

//---measure the location of active graphs
Function Measure_LC(ctrlName) : ButtonControl
	String ctrlName
	if(strlen(winname(0,4))>0)
		string info=layoutinfo("","layout")
		string selected=stringbykey("SELECTED",info,":")
		if(itemsinlist(selected,",")>0)
			variable posLeft=str2num(stringbykey("left",layoutinfo("",stringfromlist(0,selected,",")))) 
			variable posTop=str2num(stringbykey("top",layoutinfo("",stringfromlist(0,selected,",")))) 
			if (strlen(winlist(stringfromlist(0,selected,","),";","win:1"))>0)//graph exists
	 			getwindow $stringfromlist(0,selected,",") gsize
				variable left=v_left,right=v_right,top=v_top,bottom=v_bottom
				getwindow $stringfromlist(0,selected,",") psize
				left+=v_left;right-=v_right;top+=v_top;bottom-=v_bottom
				SetVariable PLOT_TOP, win=LayoutControl,value= _NUM:round(top)
				SetVariable PLOT_LEFT, win=LayoutControl,value= _NUM:round(left)
				TitleBox LT_LC , win=LayoutControl,title="("+num2str((posLeft))+","+num2str((postop))+")"
				TitleBox RB_LC , win=LayoutControl,title="("+num2str(round(posLeft+v_right-v_left))+","+num2str(round(postop+v_bottom-v_top))+")"
				SetVariable PLOT_RIGHT, win=LayoutControl,value= _NUM:round(right)
				SetVariable PLOT_BOTTOM, win=LayoutControl,value= _NUM:round(bottom)
				SetVariable PLOT_SIZEW, win=LayoutControl,value= _NUM:round(v_right-v_left)
				SetVariable PLOT_SIZEH, win=LayoutControl,value= _NUM:round(v_bottom-v_top)
			endif
		else
			TitleBox LT_LC , win=LayoutControl,title="(,)"
			TitleBox RB_LC , win=LayoutControl,title="(,)"		
		endif
	endif
End

//---moves selected graphs by a number
Function MoveGraphs(ctrlName) : ButtonControl
	String ctrlName
	variable moveleft=0,movetop=0
	controlinfo/w=LayoutControl Move_num
	if(stringmatch(ctrlName,"*left*"))
		moveleft=-v_value			
	endif
	if(stringmatch(ctrlName,"*right*"))
		moveleft=v_value				
	endif
	if(stringmatch(ctrlName,"*top*"))
		movetop=-v_value				
	endif
	if(stringmatch(ctrlName,"*bottom*"))
		movetop=v_value				
	endif
	if(stringmatch(ctrlName,"*100*"))
		moveleft*=10
		movetop*=10
	endif
	if(strlen(winname(0,4))>0)
		string info=layoutinfo("","layout")
		string selected=stringbykey("SELECTED",info,":")
		variable i
		for(i=0;i<itemsinlist(selected,",");i+=1)
			ModifyLayout left($stringfromlist(i,selected,","))=str2num(stringbykey("left",layoutinfo("",stringfromlist(i,selected,","))))+moveleft
			ModifyLayout top($stringfromlist(i,selected,","))=str2num(stringbykey("top",layoutinfo("",stringfromlist(i,selected,","))))+movetop
		endfor
		dowindow /F $winname(0,4)
		dowindow /F LayoutControl	
	endif
	execute /p /q "Measure_LC(\"\")"
End

//---aligns selected graphs left/top
Function AlignGraphs(ctrlName) : ButtonControl
	String ctrlName
	controlinfo/w=LayoutControl Move_num
	variable moveleft=(stringmatch(ctrlName,"*left*"))
	variable movetop=(stringmatch(ctrlName,"*top*"))	
	if(strlen(winname(0,4))>0)
		string info=layoutinfo("","layout")
		string selected=stringbykey("SELECTED",info,":")
		if(strlen(selected)>0)
			variable i,mostleftpos=inf,mosttoppos=inf
			for(i=0;i<itemsinlist(selected,",");i+=1)
				mostleftpos=min(mostleftpos,str2num(stringbykey("left",layoutinfo("",stringfromlist(i,selected,",")))))
				mosttoppos=min(mosttoppos,str2num(stringbykey("top",layoutinfo("",stringfromlist(i,selected,",")))))
			endfor	
			for(i=0;i<itemsinlist(selected,",");i+=1)
				if(moveleft)
					ModifyLayout left($stringfromlist(i,selected,","))=mostleftpos
				else
					ModifyLayout top($stringfromlist(i,selected,","))=mosttoppos
				endif
			endfor
		endif
		dowindow /F $winname(0,4)
		dowindow /F LayoutControl	
	endif
	execute /p /q "Measure_LC(\"\")"
End

//---update of the plot params for graphs selected on alyout
Function LC_PLOTSIZE(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	variable minval,maxval
	if(strlen(winname(0,4))>0)
		string info=layoutinfo("","layout")
		string selected=stringbykey("SELECTED",info,":")
		variable i
		for(i=0;i<itemsinlist(selected,",");i+=1)			
			if(stringmatch(ctrlName,"*left*"))
				ModifyGraph/w=$stringfromlist(i,selected,",") margin(left)=varNum
			endif
			if(stringmatch(ctrlName,"*right*"))
				ModifyGraph/w=$stringfromlist(i,selected,",") margin(right)=varNum
			endif			
			if(stringmatch(ctrlName,"*top*"))
				ModifyGraph/w=$stringfromlist(i,selected,",") margin(top)=varNum
			endif	
			if(stringmatch(ctrlName,"*bottom*"))
				ModifyGraph/w=$stringfromlist(i,selected,",") margin(bottom)=varNum
			endif			
			if(stringmatch(ctrlName,"*sizeh*"))
				ModifyGraph/w=$stringfromlist(i,selected,",") height=varNum
			endif		
			if(stringmatch(ctrlName,"*sizew*"))
				ModifyGraph/w=$stringfromlist(i,selected,",") width=varNum
			endif	
		endfor
		execute /p /q "dowindow /F "+winname(0,4)
		execute /p /q "dowindow /F LayoutControl"	
		execute /p /q "Measure_LC(\"\")"					
	endif		
end

//---changes to transparent and no frame
Function SetFrame_LC(ctrlName) : ButtonControl
	String ctrlName
	if(strlen(winname(0,4))>0)
		ModifyLayout trans=1,frame=0
		dowindow /F $winname(0,4)
		dowindow /F LayoutControl
	endif
End

//---brings the graph to front
Function BringFront(ctrlName) : ButtonControl
	String ctrlName
	if(strlen(winname(0,4))>0)
		string info=layoutinfo("","layout")
		string selected=stringbykey("SELECTED",info,":")
		variable i
		for(i=0;i<itemsinlist(selected,",");i+=1)			
			dowindow /f $stringfromlist(i,selected,",") 
		endfor
	endif
End
//---memory management 
Function FindWavesMb_LC()
	string waves=DataFolderDir(2  )
	waves= ReplaceString("WAVES:", waves, "") 
	waves=RemoveEnding(waves)
	waves=RemoveEnding(waves)
	variable wcount,memsize=0,wmem
	string wavesize
	for(wcount=0;wcount<itemsinlist(waves,",");wcount+=1)
		wavesize=waveinfo($stringfromlist(wcount,waves,","),0)		
		wmem=numberbykey("SIZEINBYTES",wavesize)
		memsize+=wmem
	endfor
	return memsize/(2^10)
end

Function FindSubFolderSize_LC(DF)
	string DF
	variable mem=0
	string DFolder=getdatafolder(1)	
	if(stringmatch(DF,"root"))
		setdatafolder root:
	elseif(datafolderexists(DF))
		setdatafolder $DF
	else
		return 0
	endif
	if (CountObjects("",4)==0)//no subfolders
		return FindWavesMb_LC()		
	else
		variable i
		for(i=0;i<CountObjects("",4);i+=1)
			mem+=FindSubFolderSize_LC(DF+""+GetIndexedObjName("", 4, i )+":")
			setdatafolder $DF
		endfor		
		mem+=FindWavesMb_LC()
	endif 
	setdatafolder $DFolder
	return mem
end
//--------------------------manage windows procedures-----------------
//--------------------------manage windows procedures-----------------
//--------------------------manage windows procedures-----------------


//----manages graphs on layouts
Function LC_G_on_L(ctrlName) : ButtonControl
	String ctrlName
	string graphs
	string graphlist_onlayouts=""
	variable laynum,graphnum,pagenum
	for (laynum=0;laynum<itemsinlist(winlist("*",";","WIN:4"));laynum+=1)//finds all layouts
		string currentlayout=stringfromlist(laynum,winlist("*",";","WIN:4"))
		string info=layoutinfo(currentlayout,"layout")
		variable currentpage=numberbykey("CURRENTPAGENUM",info,":")
		for(pagenum=0;pagenum<numberbykey("NUMPAGES",info,":");pagenum+=1)//finds all pages
			LayoutPageAction/w=$currentlayout page=pagenum+1
			for(graphnum=0;graphnum<numberbykey("NUMOBJECTS",layoutinfo(currentlayout,"layout"),":");graphnum+=1)//finds all graphs
				if(stringmatch(ctrlName,"*show*"))
					dowindow/F $stringbykey("NAME",layoutinfo(currentlayout,num2str(graphnum)),":")
				elseif(stringmatch(ctrlName,"*hide*"))
					dowindow/HIDE=1 $stringbykey("NAME",layoutinfo(currentlayout,num2str(graphnum)),":")
				endif
				graphlist_onlayouts+=stringbykey("NAME",layoutinfo(currentlayout,num2str(graphnum)),":")+";"
			endfor
		endfor
		LayoutPageAction/w=$currentlayout page=currentpage
	endfor
	if(stringmatch(ctrlName,"*not*"))//work on graphs not on layouts
		for (graphnum=0;graphnum<itemsinlist(winlist("*",";","WIN:1"));graphnum+=1)//finds all graphs
			graphs=stringfromlist(graphnum,winlist("*",";","WIN:1"))
			if(FindListItem(graphs,graphlist_onlayouts,";")==-1)//not on layout
				if(stringmatch(ctrlName,"*sh*"))
					dowindow/F $graphs
				elseif(stringmatch(ctrlName,"*hi*"))
					dowindow/HIDE=1 $graphs
				elseif(stringmatch(ctrlName,"*kill*"))
					dowindow/k $graphs					
				endif			
			endif
		endfor
	endif

End

//-----show plots that reference DF
function DF_plot(DF,deep,delete)
	string DF
	variable deep,delete
	variable graphnum,tracenum,foundplot,subDF
	string graphname,tracename
	setdatafolder DF
	for (graphnum=0;graphnum<itemsinlist(winlist("*",";","WIN:1"));graphnum+=1)//finds all graphs
		graphname=stringfromlist(graphnum,winlist("*",";","WIN:1"),";")
		if(strlen(WaveList("*", ";", "win:"+graphname ))>0)			
			if(delete)
				killwindow /z $graphname
			else
				dowindow/f $graphname
			endif
		endif
	endfor
	if(deep)
		string Folders=stringbykey("FOLDERS",DataFolderDir(1),":")
		for (subDF=0;subDF<itemsinlist(Folders,",");subDF+=1)
			if(DataFolderExists(getdatafolder(1)+""+stringfromlist(subDF,Folders,",")))
				DF_plot(getdatafolder(1)+""+stringfromlist(subDF,Folders,","),deep,delete)
			else
				DF_plot(getdatafolder(1)+"'"+stringfromlist(subDF,Folders,",")+"'",deep,delete)
			endif
			setdatafolder DF
		endfor
	endif	
	int err = GetRTError(0)
	if (err != 0)
		Printf "Stopping background task because of error %d\r", err
		return 1	
	endif

	
	return 1
end
//---edit all waves in selected datafolder
Function LC_EditfromDF(ctrlName) : ButtonControl
	String ctrlName
	execute/p/q replacestring("waves:",datafolderdir(2),"edit/k=1 ",0,1)
End
//---shows all plots that reference waves in selected datafolder
Function LC_plotsfromDF(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1),checkDF=DF+";"
	controlinfo/w=LayoutControl LC_subDF
	DF_plot(DF,v_value,0)
	setdatafolder DF
End

//---deletes plots in DF
Function LC_deleteDF_plots(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1),checkDF=DF+";"
	controlinfo/w=LayoutControl LC_delete_graphs
	variable delete_graphs=v_value
	controlinfo/w=LayoutControl LC_subDF
	DF_plot(DF,v_value,delete_graphs)
	setdatafolder DF
	killdatafolder/z DF
End


//-----------------------------------GC---------------------------------------
//-----------------------------------GC---------------------------------------
//-----------------------------------GC---------------------------------------
//-----------------------------------GC---------------------------------------

//---creates the graphcontrol panel and initializes the graphcontrol directory
function GraphControlInit()
	string DF=getdatafolder(1)
	newdatafolder/o/s root:GraphControl
	string/g ColorTableList
	newdatafolder/o/s ColorTables
	//ColorTableList=
	GCpopulateColorTables()
	//GCcreateTransColorTables()
	setdatafolder root:GraphControl
	make/o/n=(0,9)/t listtext
	make/o/n=0 listselect
	make/o/n=9/t listtitle={"Pos","Color","Y wave","X Wave","Y DF","X DF","Y Axis","X Axis","Size"}
	make/t/o/n=(0,0) LeftFolderListText,RightFolderListText
	make/o/n=(1,2,3) LeftFolderListSelect,RightFolderListSelect,DFSelectSave
	make/t/o/n=0 ImageListText
	make/t/o/n=5 ImageListTitle={"Name","Size","DF","Y axis","X axis"}
	make/o/n=(dimsize(LeftFolderListText,0)*2,4) LeftFolderListColor
	make/o/n=(dimsize(RightFolderListText,0)*2,4) RightFolderListColor
	make/t/n=2/o CurrentDF=DF
	//---color tabel waves
	make/o/n=(256,2) ColorTableShowWave=p
	make/o/n=(9,4) GCCol
	GCCol[][0]=60000								//---plot area
	GCCol[][1]={65535,60000,60000,16000}	//---traces
	GCCol[][2]={65535,60000,55000,12000}	//---advanced
	GCCol[][3]={65535,65535,50000,12000}	//---error bars
	GCCol[][4]={56000,65535,50000,12000}	//---offset
	GCCol[][5]={60000,65535,62000,32000}	//---axes
	GCCol[][6]={60000,65535,65535,32000}	//---folders
	GCCol[][7]={60000,62000,65535,32000}	//---images
	GCCol[][8]={62000,60000,65535,32000}	//---trace	
	//---3d waves
//	make/o/n=(256,3) Color3d
//	make/o/n=(256,4) Color3dCol

	variable/g MustUpdate=1
	string/g axisleft,axisbottom,PlotName="",SubPlotWindows=""
	make/o/n=(1,2,3) DFselect=0
	make/o/t/n=(1,2) DFname=""	
	dowindow /k GraphControl	//---erase prev. version
	NewPanel /k=1/W=(200,50,600,600)/n=GraphControl/flt=0 as "Graph Contol" 
	newimage/host=GraphControl /n=ColorTableDisplay root:GraphControl:ColorTableShowWave
	newimage/host=GraphControl /n=ColorTableDisplayImage root:GraphControl:ColorTableShowWave
	setwindow GraphControl hook(click)=ColorTableClickHook
	setwindow GraphControl activeChildFrame=0
	//---main buttons
	Button PLOT_NEW,pos={2,12},size={40,32},proc=GraphControlNewPlot,title="New",win=GraphControl
	Button PLOT_NEW,fColor=(48896,49152,65280),win=GraphControl
	Button PLOT_FRONT,pos={42,12},size={40,32},proc=GraphControlShowPlot,title="Show",win=GraphControl
	Button PLOT_FRONT,fColor=(48896,49152,65280),win=GraphControl
	Button PLOT_Layout,pos={82,12},size={60,32},proc=GraphControlLayout,title="To Layout",win=GraphControl
	Button PLOT_Layout,fColor=(48896,49152,65280),win=GraphControl
	Button PLOT_DUPLICATE,pos={142,12},size={90,32},proc=GraphControlDuplicateDF,title="Duplicate @DF",win=GraphControl
	Button PLOT_DUPLICATE,fColor=(48896,49152,65280),win=GraphControl
	Button PLOT_CHANGEDF,pos={232,12},size={70,32},proc=GraphControlDuplicateDF,title="Replace DF",win=GraphControl
	Button PLOT_CHANGEDF,fColor=(48896,49152,65280),win=GraphControl
	CheckBox PLOT_PRINT pos={307,22},size={57,15},value= 0,title="Print commands",win=GraphControl,win=GraphControl
	//---menu buttons
	Button GC_PLOT_AREA,proc=GraphControlControlsButtonProc,userdata=  "active",win=GraphControl
	Button GC_TRACES,proc=GraphControlControlsButtonProc,userdata=  "active",win=GraphControl
	Button GC_MARKERS,proc=GraphControlControlsButtonProc,userdata=  "active",win=GraphControl
	Button GC_ERRORS,proc=GraphControlControlsButtonProc,userdata=  "active",win=GraphControl
	Button GC_OFFSET,proc=GraphControlControlsButtonProc,userdata=  "active",win=GraphControl
	Button GC_AXES,proc=GraphControlControlsButtonProc,userdata=  "active",win=GraphControl
	Button GC_FOLDERS,proc=GraphControlControlsButtonProc,userdata=  "active",userdata(position)="00",userdata(height)="150",userdata(mousemoving)="",win=GraphControl
	Button GC_IMAGE,proc=GraphControlControlsButtonProc,userdata=  "active",userdata(position)="00",userdata(height)="170",userdata(mousemoving)="",win=GraphControl
	//getwindow GraphControl wsize
	Button GC_LISTS,proc=GraphControlControlsButtonProc,userdata=  "inactive",pos={0,0},userdata(height)="150",win=GraphControl
	//---hook functions -link to plots
	SetWindow GraphControl,hook(newgraphcontrol)=GraphControlPanelHook	
	SetWindow GraphControl,userdata(showTraces)="1"
	PopupMenu PLOT_SUBWINDOW value=#"root:graphcontrol:subplotwindows",win=GraphControl
	ListBox PLOT_TRACE_LIST,listWave=root:graphcontrol:listtext,win=GraphControl
	ListBox PLOT_TRACE_LIST,selWave=root:graphcontrol:listselect,win=GraphControl
	ListBox PLOT_TRACE_LIST,titleWave=root:graphcontrol:listtitle,mode= 9,win=GraphControl
	ListBox PLOT_TRACE_LIST,widths={35,35,100,100,150,150,80,80},userColumnResize= 1,win=GraphControl

	setdatafolder DF	
	UpdateDirFolder(getdatafolder(1),"LEFT")
	UpdateDirFolder(getdatafolder(1),"RIGHT")
	FindTopPLot()
	UpdateFolderColors()
	GraphControlPanelUpdate()
	setdatafolder DF	
end

//---converts all Igor color tables to waves
Function/s GCpopulateColorTables()
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:ColorTables:
	variable colT,dd,ff,i
	//---native color tables
	for(colT=0;colT<itemsinlist(CTabList());colT++)
		colorTab2Wave $stringfromlist(colT,CTabList())
		wave M_colors
		setscale/I x,0,255,"",M_colors
		insertpoints/m=1 3,1,M_colors
		M_colors[][3]=65535
		make/o/n=(256,4)/free TempCol256=M_colors(x)[q]
		if(dimsize(M_colors,0)<256)
			for(i=0;i<3;i++)
				make/o/n=(dimsize(M_colors,0))/free Temp_colors=m_colors[p][i]
				interpolate2/n=256/t=1 /y=TempCol_ Temp_colors
				TempCol256[][i]=TempCol_[p]
			endfor
		endif
		duplicate/o TempCol256,$stringfromlist(colT,CTabList())

	endfor
	killwaves/z M_colors
	//---expanded color tables
	pathinfo igor 
	newpath/o/q igorCol,( S_path+"Color Tables")
	for(dd=0;dd<itemsinlist(IndexedDir(igorCol, -1, 0));dd++)	//---all color directories
		pathinfo igorCol 
		newpath/o/q igorColDeep,( S_path+IndexedDir(igorCol, dd, 0))
		string list= Indexedfile(igorColDeep, -1, "????")
		for(ff=0;ff<itemsinlist(list);ff++)	//---all color directories
			LoadWave/P=igorColDeep /o/q Indexedfile(igorColDeep, ff, "????")
			wave newcol=$removeending(S_waveNames)
			insertpoints/m=1 3,1,newcol
			newcol[][3]=65535
			setscale/I x,0,255,"",newcol
			make/o/n=(256,4)/free TempCol256=newcol(x)[q]
			if(dimsize(newcol,0)<256)
				for(i=0;i<3;i++)
					make/o/n=(dimsize(newcol,0))/free Temp_colors=newcol[p][i]
					interpolate2/n=256/t=1 /y=TempCol_ Temp_colors
					TempCol256[][i]=TempCol_[p]
				endfor
			endif
			killwaves/z newcol
			duplicate/o TempCol256,$replacestring("-",removeending(S_waveNames),"_")
		endfor
	endfor 
	killwaves/z TempCol_,Temp_colors,newcol
	GCcreateTransColorTables()
	setdatafolder DF	
end

//---create transparent versions of the color tables
function GCcreateTransColorTables()
	//---create transparent versions
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:
	svar ColorTableList
	ColorTableList= removeending(replacestring(",",replacestring("WAVES:",DataFolderDir(2,root:GraphControl:ColorTables),""),";"))

	variable trans,waves
	for(trans=1;trans<=4;trans++)
		newdataFolder/s/o root:GraphControl:ColorTables:$"TRANS"+num2str(trans)
		for(waves=0;waves<itemsinlist(ColorTableList);waves++)
			duplicate/o root:GraphControl:ColorTables:$stringfromlist(waves,ColorTableList),$stringfromlist(waves,ColorTableList)
			wave newColwave=$stringfromlist(waves,ColorTableList)
			newColwave[][3]=65535*((5-trans)/4)
		endfor
	endfor
	setdatafolder DF
end
//---create a master wave to show all color tables
Function MasterColorTable(variable PeakRow, string parentwindow,[string transinfo,string maincontrol])
	string DF=getdatafolder(1)
	variable i,row,col,prevCol=-1,prevrow=-1
	variable margin_left=32,disp_width=255
	variable margin_top=4,disp_height=16

	setdatafolder root:GraphControl
	svar ColorTableList
	make/o/n=( (PeakRow+0)*(margin_left+disp_width), (ceil(itemsinlist(ColorTableList)/PeakRow)+0)*(margin_top+disp_height),4) ColorTableShowWaveAll,ColorTableShowWaveCol=nan
	redimension/W/n=(-1,-1,0) ColorTableShowWaveAll
	setdatafolder root:GraphControl:ColorTables:
	
	for(i=0;i<itemsinlist(ColorTableList);i++)	//---all color waves
		wave colTable=$stringfromlist(i,ColorTableList)
		row=mod(i,PeakRow)
		col=floor(i/PeakRow)
		variable start_left=row*(margin_left+disp_width)+margin_left
		variable start_top=col*(margin_top+disp_height)+margin_top
		ColorTableShowWaveAll[start_left-margin_left,start_left+disp_width-1][start_top-margin_top,start_top+disp_height-1]=i
		ColorTableShowWaveCol[start_left,start_left+disp_width-1][start_top,start_top+disp_height-1][]=colTable[p-start_left][r]
		
	endfor
	//---display the colortables
	dowindow $parentwindow
	if(v_flag)
		if(stringmatch(parentwindow,"GraphControl"))
			controlinfo/w=GraphControl $transinfo
			variable trans=v_value
			ColorTableShowWaveCol[][][3]=65535*(5-trans)/4
		else
			ColorTableShowWaveCol[][][3]=65535
		endif
		dowindow/k GraphControlCT
		getwindow $parentwindow wsize 
		newpanel/K=1/n=GraphControlCT/w=(v_left+100,v_top,v_left+500,v_top+400) as "Color Tables"
		NewImage/n=ColorTableImage/host=GraphControlCT root:GraphControl:ColorTableShowWaveCol
		
		movesubwindow/w=GraphControlCT#ColorTableImage fnum=(0,0,1,1)
		ModifyGraph/w=GraphControlCT#ColorTableImage margin=5, nticks=0,axThick=0
		setwindow GraphControlCT hook(mouseclick)=ColotTableMouseClick,userdata(parent)=parentwindow
		setwindow GraphControlCT userdata(control)=maincontrol
	endif
	setdatafolder DF	
end
//---returns the table number
Function ColotTableMouseClick(s)
	STRUCT WMWinHookStruct &s
	variable setCT=-1
	if(s.eventCode==3)//---mouse down
		string DF=getdatafolder(1)
		setdatafolder root:GraphControl
		wave ColorTableShowWaveAll
		svar ColorTableList
		setCT= ColorTableShowWaveAll[ (s.mouseloc.h-5)*dimsize(ColorTableShowWaveAll,0)/(s.winRect.right-10)][(s.mouseloc.v-5)*dimsize(ColorTableShowWaveAll,1)/(s.winRect.bottom-10)]
		setdatafolder DF	
	endif
	if(setCT>=0)
		string parent=getuserdata("GraphControlCT","","parent")
		dowindow $parent
		if(v_flag)
			if(stringmatch(parent,"GraphControl"))
				
				string control=getuserdata("GraphControlCT","","control")
				popupmenu $control,mode=setCT+1,win=$parent
				if(stringmatch(control,"TRACE_ADVANCE_COLORTABLE_NAME"))
					changetraceparams(control,setCT+1,stringfromlist(setCT,ColorTableList))
				else
					IMAGECOLORTABLE(control,setCT+1,stringfromlist(setCT,ColorTableList))
				endif
				doupdate
				updatetracecontrols()
			else		//---color wheel
				popupmenu ColorTableMenu,mode=setCT+1,win=$parent
				drawCWshape()
			endif
		endif
		execute /p/q "dowindow/k GraphControlCT"
	endif
	return 1
end
//---computes and activates the color table window
Function ColorTableClickHook(s)
	STRUCT WMWinHookStruct &s
	if(s.eventCode==3)//---mouse down
		string name=s.winName
		getwindow $name wsize
		if(stringmatch(name,"*colortabledisplay*"))
			string transinfo="TRACE_ADVANCE_COLORTABLE_TRANS"
			string maincontrol = "TRACE_ADVANCE_COLORTABLE_NAME"
			if(stringmatch(name,"*colortabledisplayImage"))
				transinfo="PLOT_IMAGE_COLORTABLE_TRANS"
				maincontrol = "PLOT_IMAGE_COLORTABLE_NAME"
			endif
			MasterColorTable(5,name[0,strsearch(s.winName,"#",0)-1],transinfo=transinfo,maincontrol=maincontrol)
		endif
	endif
end

//---gets the name of the most top plot, or a subwindow
Function FindTopPLot()
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl
	svar PlotName,SubPlotWindows
	PlotName=""
	SubPlotWindows=""
	String WindowList= winlist("!GraphControl*",";","WIN:65")		//---shows all panels and graphs
	variable win=0,found=-1,subwin=0
	for(win=itemsinlist(WindowList)-1;win>=0;win--)					//---find the most top graph/panel with a subwindow
		string CurrentWindow=stringfromlist(win,WindowList)
		string ChildWindows=ChildWindowList(CurrentWindow)
		if(wintype(CurrentWindow)==1)				//---graph
			//print WinRecreation(CurrentWindow, 0 )
			found=win
			PlotName=CurrentWindow
			SubPlotWindows="_none_;"+ChildWindows
		elseif(wintype(CurrentWindow)==7)			//---panel
			for(subwin=itemsinlist(ChildWindows)-1;subwin>=0;subwin--)	//---all subwindows
				if(wintype(CurrentWindow+"#"+stringfromlist(subwin,ChildWindows))==1)				//---graph
					found=win
					PlotName=CurrentWindow
					SubPlotWindows=ChildWindows
				endif
			endfor
		endif
	endfor
	setdatafolder DF	
end

//---the plot we are working on
Function/s WorkingPlotName()
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl
	svar PlotName,SubPlotWindows
	setdatafolder DF
	if(strlen(PlotName)>0)
		dowindow GraphControl
		if(v_flag)
			controlinfo/w=GraphControl PLOT_SUBWINDOW
			if( (stringmatch(s_value,"_none_"))||(stringmatch(s_value,"")))
				return PlotName
			else
				return PlotName+"#"+s_value
			endif
		else
			return ""
		endif
		else
			return ""
	endif
end

//---change subwindow
Function Subwindow_PopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	GraphControlPanelUpdate(update=1)
End
//---update of graph controls--------------------------------------------------
function GraphControlPanelUpdate([update])
	variable update
	string DF=getdatafolder(1)
	dowindow GraphControl
	setdatafolder root:graphcontrol
	nvar MustUpdate
	svar PlotName,SubPlotWindows
	if( ((	MustUpdate)||(update))&&(v_flag))
		doupdate
		wave/t listtext,listtitle
		wave listselect
		wave/t ImageListText,ImageListTitle
		wave/t LeftFolderListText,RightFolderListText
		wave LeftFolderListSelect,RightFolderListSelect,LeftFolderListColor,RightFolderListColor,GCCol
		SetDimLabel 2,1,foreColors,LeftFolderListSelect,RightFolderListSelect
		SetDimLabel 2,2,backColors,LeftFolderListSelect,RightFolderListSelect
		redimension /n=(dimsize(LeftFolderListText,0)*2,4) LeftFolderListColor
		redimension /n=(dimsize(RightFolderListText,0)*2,4) RightFolderListColor
		make/t/n=2/o CurrentDF=DF
		variable CurrGCCol=0
		setdatafolder $DF
		
		//----draw envoronment
		setdrawlayer /w=GraphControl userback
		drawaction/w=GraphControl delete
		//---plot margins
		getwindow GraphControl wsizeDC
		variable plotWidth=v_right-v_left,plotHeight=v_bottom-v_top
		Button GC_PLOT_AREA,pos={-4,50},size={plotWidth+8,25},fColor=(GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),fSize=14,proc=GraphControlControlsButtonProc,title="Plot area",win=GraphControl
		controlinfo/w=GraphControl GC_PLOT_AREA
		variable showPlotArea=stringmatch(S_UserData,"active")
		//---plot name
		SetVariable PLOT_NAME,pos={2,77},size={plotWidth-210,18.00},proc=PLOTSIZE,title="Name: ",win=GraphControl,disable=showPlotArea
		FindTopPLot()	//---the plot to work on
		PopupMenu PLOT_SUBWINDOW pos={plotWidth-200,77},value=#"root:graphcontrol:subplotwindows",proc=Subwindow_PopMenuProc,win=GraphControl,disable=showPlotArea
		
		//---plot size
		SetVariable PLOT_SIZEW,pos={9,100},size={90.00,18.00},proc=PLOTSIZE,title="Width",win=GraphControl,disable=showPlotArea
		SetVariable PLOT_SIZEW,valueBackColor=(56576,56576,56576),win=GraphControl,disable=showPlotArea
		SetVariable PLOT_SIZEW,limits={-1,inf,10},value= _NUM:120,win=GraphControl,disable=showPlotArea
		SetVariable PLOT_SIZEH,pos={4,120},size={95.00,18.00},proc=PLOTSIZE,title="Height",win=GraphControl,disable=showPlotArea
		SetVariable PLOT_SIZEH,valueBackColor=(56576,56576,56576),win=GraphControl,disable=showPlotArea
		SetVariable PLOT_SIZEH,limits={-1,inf,10},value= _NUM:100,win=GraphControl,disable=showPlotArea
		SetVariable PLOT_PERUNIT_SIZEH,pos={110.00,120},size={120,18.00},proc=PLOTSIZE,title="perUnit",win=GraphControl,disable=showPlotArea
		SetVariable PLOT_PERUNIT_SIZEH,valueBackColor=(56576,56576,56576),win=GraphControl,disable=showPlotArea
		SetVariable PLOT_PERUNIT_SIZEH,limits={0,inf,1},value= _NUM:1,format="%.5g",win=GraphControl,disable=showPlotArea
		PopupMenu PLOT_PERUNIT_AXIS_BOTTOM,pos={230,100-1},size={91.00,19.00},proc=PLOTAXISSIZEPopMenuProc,title="* Axis",win=GraphControl,disable=showPlotArea
		PopupMenu PLOT_PERUNIT_AXIS_BOTTOM,mode=1,popvalue=stringfromlist(0,getaxistype(1)),value= #"getaxistype(1)",win=GraphControl,disable=showPlotArea
		SetVariable PLOT_PERUNIT_SIZEW,pos={110.00,100},size={120,18.00},proc=PLOTSIZE,title="perUnit",win=GraphControl,disable=showPlotArea
		SetVariable PLOT_PERUNIT_SIZEW,valueBackColor=(56576,56576,56576),win=GraphControl,disable=showPlotArea
		SetVariable PLOT_PERUNIT_SIZEW,limits={0,inf,1},value= _NUM:1,format="%.5g",win=GraphControl,disable=showPlotArea
		PopupMenu PLOT_PERUNIT_AXIS_LEFT,pos={230,120-1},size={91.00,19.00},proc=PLOTAXISSIZEPopMenuProc,title="* Axis",win=GraphControl,disable=showPlotArea
		PopupMenu PLOT_PERUNIT_AXIS_LEFT,mode=1,popvalue=stringfromlist(0,getaxistype(0)),value= #"getaxistype(0)",win=GraphControl,disable=showPlotArea
	
		variable marginY=65,marginX=160
		//---recreation
		TitleBox PLOT_INFO,pos={4,marginY+77},size={56.00,15.00},frame=0,title="Recreation",win=GraphControl,disable=showPlotArea	
		Button PLOTINFO_COPY,pos={5,marginY+90},size={50.00,28.00},proc=PLOTINFOCOPY,title="Copy",win=GraphControl,disable=showPlotArea
		Button PLOTINFO_PASTE,pos={55,marginY+90},size={50.00,28.00},proc=PLOTINFOPASTE,title="Paste",win=GraphControl,disable=showPlotArea
		//--axis utilities
		Button PLOT_ENHANCE,pos={4,marginY+120},size={60,20},proc=GraphControlEnhance,title="Enhance",win=GraphControl,disable=showPlotArea
		CheckBox PLOT_SWAPXY,pos={70,marginY+122},size={57.00,15.00},proc=PLOTAXISMODE,title="Swap XY",win=GraphControl,disable=showPlotArea
		SetVariable PLOT_EXPAND pos={135,marginY+120},size={80,18.00},limits={0,10,0.5},proc=PLOTSIZE,title="Expand",win=GraphControl,disable=showPlotArea
		//---margins
		TitleBox PLOT_MARGIN_INFO,pos={plotWidth-marginX-42,marginY+77},size={56.00,15.00},frame=0,title="Margins",win=GraphControl,disable=showPlotArea	
		SetVariable PLOT_MARGIN_ALL,pos={plotWidth-marginX+54.00,98+marginY},size={55.00,18.00},proc=PLOTSIZE,title="all",win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_ALL,valueBackColor=(65535,65535,65535),win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_ALL,limits={-1,1000,10},value= _NUM:0,win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_TOP,pos={plotWidth-marginX+39.00,77+marginY},size={70.00,18.00},proc=PLOTSIZE,title="Top",win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_TOP,valueBackColor=(56576,56576,56576),win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_TOP,limits={-1,1000,10},value= _NUM:20,win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_BOTTOM,pos={plotWidth-marginX+19.00,119+marginY},size={90.00,18.00},proc=PLOTSIZE,title="Bottom",win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_BOTTOM,valueBackColor=(56576,56576,56576),win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_BOTTOM,limits={-1,1000,10},value= _NUM:30,win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_LEFT,pos={plotWidth-marginX+3.00,98+marginY},size={45.00,18.00},proc=PLOTSIZE,win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_LEFT,valueBackColor=(56576,56576,56576),win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_LEFT,limits={-1,1000,10},value= _NUM:35,win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_Right,pos={plotWidth-marginX+110.00,98+marginY},size={45.00,18.00},proc=PLOTSIZE,win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_Right,valueBackColor=(56576,56576,56576),win=GraphControl,disable=showPlotArea
		SetVariable PLOT_MARGIN_Right,limits={-1,1000,10},value= _NUM:35,win=GraphControl,disable=showPlotArea
		TitleBox PLOT_TITLE_LEFT,pos={plotWidth-marginX+3.00,84+marginY},frame=0,size={20.00,15.00},title="Left",win=GraphControl,disable=showPlotArea
		TitleBox PLOT_TITLE_RIGHT,pos={plotWidth-marginX+125.00,84+marginY},frame=0,size={28.00,15.00},title="Right",win=GraphControl,disable=showPlotArea
		//---traces--------------------------------------------------------------------
		variable plotControlsY=72+(showPlotArea==0)*138
		CurrGCCol++
		Button GC_TRACES,pos={-4,plotControlsY},size={plotWidth+8,25},fColor=(GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),fSize=14,proc=GraphControlControlsButtonProc,title="Trace info",win=GraphControl
		controlinfo/w=GraphControl GC_TRACES
		variable showTracesArea=stringmatch(S_UserData,"active")
		SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol],GCCol[3][CurrGCCol]),linethick= 0
		drawrect/w=GraphControl 0,plotControlsY+22,plotWidth,plotControlsY+22+(showTracesArea==0)*95
		//---trace main
		PopupMenu TRACEMAIN_MODE,pos={5,plotControlsY+66-40},size={117.00,19.00},proc=TRACE_PARAMS,win=GraphControl,disable=showTracesArea
		PopupMenu TRACEMAIN_MODE,mode=5,popvalue="Lines and markers",value= #"\"Lines;Sticks to zero;Dots;Markers;Lines and markers;Bars;Cityscape;Fill to zero;Sticks and markers\"",win=GraphControl,disable=showTracesArea
		SetVariable TRACEMAIN_LINESIZE,pos={5,plotControlsY+87-40},size={90,18.00},proc=TRACE_VAR,title="Line size:",win=GraphControl,disable=showTracesArea
		SetVariable TRACEMAIN_LINESIZE,limits={0,10,1},value= _NUM:1,win=GraphControl,disable=showTracesArea
		PopupMenu TRACEMAIN_LINE,pos={100,plotControlsY+87-40},size={50,19},bodyWidth=50,disable=1,proc=TRACE_PARAMS,win=GraphControl,disable=showTracesArea
		PopupMenu TRACEMAIN_LINE,mode=1,value= #"\"*LINESTYLEPOP*\"",win=GraphControl,disable=showTracesArea
		PopupMenu TRACEMAIN_COL,pos={155,plotControlsY+87-40},size={50,18},proc=TRACE_PARAMS,win=GraphControl,disable=showTracesArea
		PopupMenu TRACEMAIN_COL,mode=1,popColor= (0,0,0),value= #"\"*COLORPOP*\"",win=GraphControl,disable=showTracesArea
		SetVariable TRACEMAIN_COLTRANS,pos={210,plotControlsY+87-40},size={85,18},proc=TRACE_VAR,title="Alpha:",win=GraphControl,disable=showTracesArea
		SetVariable TRACEMAIN_COLTRANS,limits={0,256,1},value= _NUM:256,win=GraphControl,disable=showTracesArea
		Button TRACEMAININFO_COPY,pos={270,plotControlsY+65-40},size={40.00,20},proc=INFOCOPY,title="Copy",win=GraphControl,disable=showTracesArea
		Button TRACEMAININFO_PASTE,pos={310,plotControlsY+65-40},size={40.00,20},proc=INFOPASTE,title="Paste",win=GraphControl,disable=showTracesArea
		TitleBox TRACEMAIN_INFO,pos={210,plotControlsY+67-40},size={56.00,15.00},title="Recreation",frame=0,win=GraphControl,disable=showTracesArea
		Button buttonTRACEMAIN_PASTE,pos={300,plotControlsY+67-20},size={80,18},proc=TRACE_PASTE,title="Paste trace",win=GraphControl,disable=max(showTracesArea,(strlen(WorkingPlotName())==0))

		//---marker/fill----------------------------------------------------------------------------
		plotControlsY+=22+(showTracesArea==0)*45
		CurrGCCol++
		Button GC_MARKERS,pos={-4,plotControlsY},size={plotWidth+8,25},fColor=(GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),fSize=14,proc=GraphControlControlsButtonProc,title="Markers/Fill/Advanced",win=GraphControl
		controlinfo/w=GraphControl GC_MARKERS
		variable showMarkerArea=stringmatch(S_UserData,"active")
		SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol],GCCol[3][CurrGCCol]),linethick= 0
		drawrect/w=GraphControl 0,plotControlsY+22,plotWidth,plotControlsY+22+(showMarkerArea==0)*55
		SetVariable TRACE_MARKERSIZE,pos={7.00,plotControlsY+30},size={105,18.00},proc=TRACE_VAR,title="Marker size:",win=GraphControl,disable=showMarkerArea
		SetVariable TRACE_MARKERSIZE,limits={0,10,1},value= _NUM:0,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_MARKER,pos={115.00,plotControlsY+30},size={50.00,19.00},proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_MARKER,mode=9,value= #"\"*MARKERPOP*\"",win=GraphControl,disable=showMarkerArea
		SetVariable TRACE_MARKERSKIP,pos={230.00,plotControlsY+30},size={60.00,19.00},proc=TRACE_VAR,title="Skip:",win=GraphControl,disable=showMarkerArea
		SetVariable TRACE_MARKERSKIP,limits={0,inf,1},value= _NUM:0,win=GraphControl,disable=showMarkerArea
	
		CheckBox TRACE_MARKEROPAQUE,pos={169.00,plotControlsY+30+2},size={57.00,15.00},value= 0,proc=TRACE_CHECK,title="Opaque",win=GraphControl,disable=showMarkerArea
		CheckBox TRACE_MARKERSTROKE,pos={7,plotControlsY+55+2},size={48.00,15.00},value= 0,proc=TRACE_CHECK,title="Stroke",win=GraphControl,disable=showMarkerArea
		SetVariable TRACE_MARKERTHICK,pos={60,plotControlsY+55},size={85.00,18.00},disable=1,proc=TRACE_VAR,title="Thick:",win=GraphControl,disable=showMarkerArea
		SetVariable TRACE_MARKERTHICK,limits={0,10,1},value= _NUM:0.5,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_MARKERCOLSTROKE,pos={148,plotControlsY+55},size={50.00,19.00},disable=1,proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_MARKERCOLSTROKE,mode=1,popColor= (0,0,0),value= #"\"*COLORPOP*\"",win=GraphControl,disable=showMarkerArea
		SetVariable TRACE_MARKERCOLSTROKETRANS,pos={200,plotControlsY+55},size={90,18},proc=TRACE_VAR,title="Alpha:",win=GraphControl,disable=showTracesArea
		SetVariable TRACE_MARKERCOLSTROKETRANS,limits={0,256,1},value= _NUM:256,win=GraphControl,disable=showMarkerArea
		//---fill
		PopupMenu TRACE_FILLTYPEplus,pos={14.00,plotControlsY+35-4},size={138,19},bodyWidth=60,proc=TRACE_PARAMS,title="\\W600 Fill type:",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_FILLTYPEplus,mode=1,popvalue="None",value= #"\"None;Erase;Solid;75%;50%;25%\"",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACEMAIN_COLFILLplus,pos={156.00,plotControlsY+35-4},size={50.00,19.00},proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACEMAIN_COLFILLplus,mode=1,popColor= (65535,0,0),value= #"\"*COLORPOP*\"",win=GraphControl,disable=showMarkerArea
		CheckBox TRACE_FILLCOLORplus,pos={7.00,plotControlsY+35},size={13.00,13.00},value= 0,proc=TRACE_CHECK,title="",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_FILLTYPEneg,pos={14.00,plotControlsY+35+20-4},size={138.00,19.00},bodyWidth=60,proc=TRACE_PARAMS,title="\\W609 Fill type:",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_FILLTYPEneg,mode=1,popvalue="Same",value= #"\"Same;None;Erase;Solid;75%;50%;25%\"",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACEMAIN_COLFILLneg,pos={156.00,plotControlsY+35+20-4},size={50.00,19.00},proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACEMAIN_COLFILLneg,mode=1,popColor= (65535,0,0),value= #"\"*COLORPOP*\"",win=GraphControl,disable=showMarkerArea
		CheckBox TRACE_FILLCOLORneg,pos={7.00,plotControlsY+35+20},size={13.00,13.00},value= 0,proc=TRACE_CHECK,title="",win=GraphControl,disable=showMarkerArea
		//---advanced
		PopupMenu TRACE_ADVANCE_SELECT,pos={7.00,plotControlsY+80},size={13.00,13.00},value="Color;Marker size;Marker number",proc=TRACE_ADVANCE_PARAMS,title="Advanced",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_ZWAVE,pos={240,plotControlsY+80},size={100,19.00},proc=TRACE_PARAMS,title="z wave",mode=3,popvalue="_none_",value= #"FindErrorWavesFolder()",win=GraphControl,disable=showMarkerArea
		CheckBox TRACE_ADVANCE_CHECK_COLOR,pos={5,plotControlsY+100-3},size={37.00,14.00},title="Color",fSize=9,fColor=(21845,21845,21845),mode=1,win=GraphControl,disable=showMarkerArea
		CheckBox TRACE_ADVANCE_CHECK_SIZE,pos={5,plotControlsY+115-3},size={37.00,14.00},title="Size",fSize=9,fColor=(21845,21845,21845),mode=1,win=GraphControl,disable=showMarkerArea
		CheckBox TRACE_ADVANCE_CHECK_NUMBER,pos={5,plotControlsY+130-3},size={37.00,14.00},title="Number",fSize=9,fColor=(21845,21845,21845),mode=1,win=GraphControl,disable=showMarkerArea	
		PopupMenu TRACE_ADVANCE_TOMODE,pos={300.00,plotControlsY+30},size={51.00,19.00},proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_TOMODE,mode=1,popvalue="None",value= #"\"None;Draw to next;Add to next;Stack on next\"",win=GraphControl,disable=showMarkerArea

		setdatafolder root:graphcontrol
		make/o/n=5 plotADVANCEDx={54,54,nan,56,56},plotADVANCEDy={plotControlsY+100,plotControlsY+130,nan,plotControlsY+138,plotControlsY+100}
		duplicate/o plotADVANCEDx,plotADVANCEDxSAVE
		SetDrawEnv/w=GraphControl  linefgc= (45000,45000,45000),linethick= 1-showMarkerArea,save
		drawpoly/w=GraphControl/abs 0,0,1,1, plotADVANCEDx,plotADVANCEDy
		setdatafolder DF
		//---advanced-color
		PopupMenu TRACE_ADVANCE_COLOR,pos={55.00,plotControlsY+100},size={246.00,19.00},bodyWidth=240,value= #"\"*COLORTABLEPOP*\"",proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		CheckBox TRACE_ADVANCE_COLOR_MIN_AUTO,pos={65.00,plotControlsY+124},size={45.00,15.00},proc=TRACE_CHECK,title="Auto:",win=GraphControl,disable=showMarkerArea
		SetVariable TRACE_ADVANCE_COLOR_MIN,pos={113.00,plotControlsY+122},value= _NUM:0,size={80.00,18.00},proc=TRACE_VAR,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MIN,pos={65,plotControlsY+144},size={50.00,17.00},proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MIN,value= "Use 1st;Color;Transparent",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_COLOR_MIN,pos={120,plotControlsY+144},size={50.00,17.00},proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_COLOR_MIN,value= #"\"*COLORPOP*\"",win=GraphControl,disable=showMarkerArea

		SetVariable TRACE_ADVANCE_COLOR_MAX,pos={258.00,plotControlsY+122},value= _NUM:0,size={80.00,18.00},proc=TRACE_VAR,win=GraphControl,disable=showMarkerArea
		CheckBox TRACE_ADVANCE_COLOR_MAX_AUTO,pos={210.00,plotControlsY+124},size={45.00,15.00},proc=TRACE_CHECK,title="Auto:",win=GraphControl,disable=showMarkerArea
		CheckBox TRACE_ADVANCE_COLOR_REV,pos={325,plotControlsY+100},size={56.00,15.00},value= 0,proc=TRACE_CHECK,title="Reverse",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MAX,pos={210,plotControlsY+144},size={50.00,17.00},proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MAX,value= "Use last;Color;Transparent",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_COLOR_MAX,pos={265,plotControlsY+144},size={50.00,17.00},proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_COLOR_MAX,value= #"\"*COLORPOP*\"",win=GraphControl,disable=showMarkerArea

//		SetVariable TRACE_ADVANCE_COLOR_TRANS,pos={265,plotControlsY+100},size={50.00,19.00},proc=TRACE_VAR,title="α",win=GraphControl,disable=showMarkerArea
//		SetVariable TRACE_ADVANCE_COLOR_TRANS,limits={0,256,1},value= _NUM:256,win=GraphControl,disable=showMarkerArea

		PopupMenu TRACE_ADVANCE_COLORTABLE_TRANS,pos={265,plotControlsY+100},size={50,17.00},proc=TRACE_PARAMS,title="α",win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_TRANS,value= #"\"Solid;75%;50%;25%\"",focusring=0,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_NAME,pos={60,plotControlsY+0100},proc=TRACE_PARAMS,win=GraphControl,disable=showMarkerArea
		PopupMenu TRACE_ADVANCE_COLORTABLE_NAME,value= #"root:GraphControl:colortablelist",bodyWidth=0,win=GraphControl,disable=showMarkerArea
		controlinfo/w= GraphControl TRACE_ADVANCE_COLORTABLE_NAME

		setactiveSubwindow GraphControl
		//---advanced-marker size
		SetVariable TRACE_ADVANCE_MARK_MIN,pos={55,plotControlsY+100},title="min Marker size",value= _NUM:1,size={140.00,18.00},proc=TRACE_VAR,win=GraphControl,disable=showMarkerArea
		SetVariable TRACE_ADVANCE_MARK_MAX,pos={200,plotControlsY+100},title="max Marker size",value= _NUM:10,size={140.00,18.00},proc=TRACE_VAR,win=GraphControl,disable=showMarkerArea
		//---error bars--------------------------------------------------------------------
		plotControlsY+=22+(showMarkerArea==0)*145
		CurrGCCol++
		Button GC_ERRORS,pos={-4,plotControlsY},size={plotWidth+8,25},fColor=(GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),fSize=14,proc=GraphControlControlsButtonProc,title="Error bars",win=GraphControl
		controlinfo/w=GraphControl GC_ERRORS
		variable showErrorArea=stringmatch(S_UserData,"active")
		SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol],GCCol[3][CurrGCCol]),linethick= 0
		drawrect/w=GraphControl 0,plotControlsY+22,plotWidth,plotControlsY+22+(showErrorArea==0)*78
		SetVariable ERROR_YP,pos={2,plotControlsY+25},size={plotWidth/2,18.00},value=_str:"",noedit= 1,frame=0,limits={-inf,inf,0},title="Error Y:",win=GraphControl,disable=showErrorArea
		SetVariable ERROR_XP,pos={plotWidth/2,plotControlsY+25},size={plotWidth,18.00},value=_str:"",noedit= 1,frame=0,limits={-inf,inf,0},title="Error X:",win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_NEW_YP,pos={2,plotControlsY+43},size={70,19.00},proc=ERROR_NEW_PopMenuProc,title="Y+",win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_NEW_YP,mode=3,popvalue="_none_",value= #"FindErrorWavesFolder()",win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_NEW_YN,pos={102,plotControlsY+43},size={70,19.00},proc=ERROR_NEW_PopMenuProc,title="Y-",win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_NEW_YN,mode=3,popvalue="_none_",value= #"FindErrorWavesFolder()",win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_NEW_XP,pos={plotWidth/2+2,plotControlsY+43},size={70,19.00},proc=ERROR_NEW_PopMenuProc,title="X+",win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_NEW_XP,mode=3,popvalue="_none_",value= #"FindErrorWavesFolder()",win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_NEW_XN,pos={plotWidth/2+102,plotControlsY+43},size={70,19.00},proc=ERROR_NEW_PopMenuProc,title="X-",win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_NEW_XN,mode=3,popvalue="_none_",value= #"FindErrorWavesFolder()",win=GraphControl,disable=showErrorArea
	
		SetVariable ERROR_CAPW,pos={2,plotControlsY+75},size={40.00,18.00},proc=ERR_VISUAL,title="-",win=GraphControl,disable=showErrorArea
		SetVariable ERROR_CAPW,limits={0,10,1},value= _NUM:4,win=GraphControl,disable=showErrorArea
		SetVariable ERROR_CAPH,pos={47,plotControlsY+75},size={40.00,18.00},proc=ERR_VISUAL,title="|",win=GraphControl,disable=showErrorArea
		SetVariable ERROR_CAPH,limits={0,10,1},value= _NUM:1,win=GraphControl,disable=showErrorArea
		SetVariable ERROR_BAR,pos={92,plotControlsY+75},size={55.00,18.00},proc=ERR_VISUAL,title="Bar:",win=GraphControl,disable=showErrorArea
		SetVariable ERROR_BAR,limits={0,10,1},value= _NUM:1,win=GraphControl,disable=showErrorArea
	
		CheckBox ERROR_SHADE,pos={160,plotControlsY+77},size={46.00,15.00},proc=ERRORBARS_CHECK,title="Shade",win=GraphControl,disable=showErrorArea
		CheckBox ERROR_SHADE,labelBack=(65535,32768,32768),value= 0,win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_SHADE_EB,pos={210,plotControlsY+75},size={50.00,19.00},proc=ERROR_SHADE_EBpopup,win=GraphControl,disable=showErrorArea
		PopupMenu ERROR_SHADE_EB,mode=1,popColor= (0,0,0),value= #"\"*COLORPOP*\"",win=GraphControl,disable=showErrorArea
		SetVariable ERROR_TRANS_SHADE,pos={265,plotControlsY+75},size={80,18.00},proc=ERROR_TRANS_SHADE,title="Alpha:",win=GraphControl,disable=showErrorArea
		SetVariable ERROR_TRANS_SHADE,format="%d",limits={0,256,1},value= _NUM:256,win=GraphControl,disable=showErrorArea
		//---offset--------------------------------------------------------------------
		plotControlsY+=22+(showErrorArea==0)*78 
		CurrGCCol++
		Button GC_OFFSET,pos={-4,plotControlsY},size={plotWidth+8,25},fColor=(GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),fSize=14,proc=GraphControlControlsButtonProc,title="Offset",win=GraphControl
		controlinfo/w=GraphControl GC_OFFSET
		variable showOffsetArea=stringmatch(S_UserData,"active")
		SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol],GCCol[3][CurrGCCol]),linethick= 0
		drawrect/w=GraphControl 0,plotControlsY+22,plotWidth,plotControlsY+22+(showOffsetArea==0)*73
		SetVariable TRACE_OFFSET_X,pos={5,plotControlsY+27},size={120,18},value=_num:0,proc=TRACE_VAR,title="Offset X:",win=GraphControl,disable=showOffsetArea
		SetVariable TRACE_OFFSET_Y,pos={5,plotControlsY+47},size={120,18},value=_num:0,proc=TRACE_VAR,title="Offset Y:",win=GraphControl,disable=showOffsetArea
		SetVariable TRACE_OFFSET_MULX,pos={135,plotControlsY+27},size={100,18},value=_num:0,proc=TRACE_VAR,title="mul X:",win=GraphControl,disable=showOffsetArea
		SetVariable TRACE_OFFSET_MULY,pos={135,plotControlsY+47},size={100,18},value=_num:0,proc=TRACE_VAR,title="mul Y:",win=GraphControl,disable=showOffsetArea
		
		//---***axes***--------------------------------------------------------------------	
		plotControlsY+=22+(showOffsetArea==0)*47
		CurrGCCol++
		Button GC_AXES,pos={-4,plotControlsY},size={plotWidth+8,25},fColor=(GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),fSize=14,proc=GraphControlControlsButtonProc,title="Axes",win=GraphControl
		controlinfo/w=GraphControl GC_AXES
		variable showAxesArea=stringmatch(S_UserData,"active")
		SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol],GCCol[3][CurrGCCol]),linethick= 0
		drawrect/w=GraphControl 0,plotControlsY+22,plotWidth,plotControlsY+22+(showAxesArea==0)*245
		//---axes
		variable axesTop=plotControlsY+15,axesLeft=2,axesWidth=plotWidth-15
		//---left axis
		variable axesnum
		string axisname="LEFT"
		for(axesnum=0;axesnum<=1;axesnum++)
			if(axesnum)
				axisname="BOTTOM"
			endif
			axesTop+=120*axesnum
			CheckBox $"TRANS_HIDE_"+axisname ,pos={axesLeft+10,axesTop+17},size={40.00,15.00},proc=AXISHIDE,title="Hide",win=GraphControl,disable=showAxesArea
			CheckBox $"TRANS_HIDE_"+axisname,value= 0,win=GraphControl,disable=showAxesArea
			PopupMenu $"PLOT_AXIS_COLOR_"+axisname,pos={axesLeft+60,axesTop+15},size={124.00,19.00},value= #"\"*COLORPOP*\"",proc=PLOTAXISSEL,title="",win=GraphControl,disable=showAxesArea
			PopupMenu $"PLOT_AXIS_"+axisname,pos={axesLeft+120,axesTop+15},size={124.00,19.00},bodyWidth=100,proc=PLOTAXISSEL,title="Axis",win=GraphControl,disable=showAxesArea
			CheckBox $"PLOT_"+axisname+"_MODE_LINEAR",pos={axesLeft+10,axesTop+40},size={47.00,15.00},proc=PLOTAXISMODE,title="Linear",win=GraphControl,disable=showAxesArea
			CheckBox $"PLOT_"+axisname+"_MODE_LINEAR",value= 1,mode=1,win=GraphControl,disable=showAxesArea
			CheckBox $"PLOT_"+axisname+"_MODE_LOG",pos={axesLeft+70,axesTop+40},size={35.00,15.00},proc=PLOTAXISMODE,title="Log",win=GraphControl,disable=showAxesArea
			CheckBox $"PLOT_"+axisname+"_MODE_LOG",value= 0,mode=1,win=GraphControl,disable=showAxesArea
			CheckBox $"PLOT_"+axisname+"_MODE_LOG2",pos={axesLeft+120,axesTop+40},size={41.00,15.00},proc=PLOTAXISMODE,title="Log2",win=GraphControl,disable=showAxesArea
			CheckBox $"PLOT_"+axisname+"_MODE_LOG2",value= 0,mode=1,win=GraphControl,disable=showAxesArea
			CheckBox $"PLOT_"+axisname+"_MODE_ZERO",pos={axesLeft+170,axesTop+40},size={41.00,15.00},proc=PLOTAXISMODE,title="Zero",win=GraphControl,disable=showAxesArea
			CheckBox $"PLOT_"+axisname+"_MODE_ZERO",value= 0,mode=0,win=GraphControl,disable=showAxesArea
			Button $"PLOT_"+axisname+"_AUTO",pos={axesLeft+260,axesTop+30},size={18,18},proc=AUTOAXIS,title="*",win=GraphControl,disable=showAxesArea
			SetVariable $"PLOT_"+axisname+"_MAX",pos={axesLeft+280,axesTop+20},size={31.00,18.00},proc=PLOTSIZE,win=GraphControl,disable=showAxesArea
			SetVariable $"PLOT_"+axisname+"_MAX",labelBack=(65535,65535,65535),value= _NUM:1,win=GraphControl,disable=showAxesArea
			SetVariable $"PLOT_"+axisname+"_MIN",pos={axesLeft+280,axesTop+40},size={51.00,18.00},proc=PLOTSIZE,win=GraphControl,disable=showAxesArea
			SetVariable $"PLOT_"+axisname+"_MIN",labelBack=(65535,65535,65535),value= _NUM:1e-307,win=GraphControl,disable=showAxesArea
			//---ticks
			button $"PLOT_"+axisname+"_AUTO_TICKS",pos={axesLeft+2,axesTop+62},size={80,20},title="Auto ticks",proc=PLOTAXISTICKS,userdata="auto",win=GraphControl,disable=showAxesArea
			SetVariable $"PLOT_"+axisname+"_TICKS",pos={axesLeft+90,axesTop+63},limits={0,100,1},size={100,18},value= _NUM:2,title="# Ticks",proc=PLOTSIZE,win=GraphControl,disable=showAxesArea
			SetVariable $"PLOT_"+axisname+"_TICKSSTART",pos={axesLeft+90,axesTop+63},limits={-inf,inf,1},value= _NUM:100,size={70,18},proc=PLOTSIZE,title="Start",win=GraphControl,disable=showAxesArea
			SetVariable $"PLOT_"+axisname+"_TICKSINC",pos={axesLeft+165,axesTop+63},limits={0,inf,1},value= _NUM:100,size={90,18},proc=PLOTSIZE,title="Delta",win=GraphControl,disable=showAxesArea
			SetVariable $"PLOT_"+axisname+"_TICKSMINOR",pos={axesLeft+260,axesTop+63},limits={0,10,1},value= _NUM:1,size={70,18},proc=PLOTSIZE,title="Minor",win=GraphControl,disable=showAxesArea	 
			CheckBox $"PLOT_"+axisname+"_STANDOFF",pos={axesLeft+10,axesTop+85},size={40.00,15.00},proc=PLOTAXISMODE,title="Standoff",win=GraphControl,disable=showAxesArea
			SetVariable $"PLOT_"+axisname+"_DISTANCE",pos={axesLeft+80,axesTop+83},value= _NUM:0,size={90,18},proc=PLOTSIZE,title="Distance",win=GraphControl,disable=showAxesArea	 
			SetVariable $"PLOT_"+axisname+"_DRAWMIN",pos={axesLeft+190,axesTop+83},limits={0,100,5},value= _NUM:0,size={120,18},proc=PLOTSIZE,title="Draw between",win=GraphControl,disable=showAxesArea	 
			SetVariable $"PLOT_"+axisname+"_DRAWMAX",pos={axesLeft+315,axesTop+83},limits={0,100,5},value= _NUM:100,size={50,18},proc=PLOTSIZE,title="-",win=GraphControl,disable=showAxesArea	 
			SetVariable $"PLOT_"+axisname+"_LABEL",value= _STR:"",pos={axesLeft+10,axesTop+107},size={axesWidth,18.00},proc=PLOT_LABEL,title="Label:",win=GraphControl,disable=showAxesArea
		
			SetDrawEnv /w=GraphControl linethick=1-showAxesArea, linefgc= (52428,52428,52428),fillpat= 0	,save
			DrawRect/w=GraphControl 1,axesTop+60,plotWidth-2,axesTop+103	
		endfor
		PopupMenu PLOT_AXIS_LEFT,value= #"getaxistype(0)",win=GraphControl,disable=showAxesArea
		PopupMenu PLOT_AXIS_BOTTOM,value= #"getaxistype(1)",win=GraphControl,disable=showAxesArea
		
		//---folders---------------------------------------------------------------------
		plotControlsY+=22+245*(showAxesArea==0)
		CurrGCCol++
		Button GC_FOLDERS,pos={-4,plotControlsY},size={plotWidth+8,25},fColor=(GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),fSize=14,proc=GraphControlControlsButtonProc,title="Folders",win=GraphControl
		controlinfo/w=GraphControl GC_FOLDERS
		variable showFoldersArea=stringmatch(S_UserData,"active")		
		variable SizeFoldersArea=str2num(getuserdata("GraphControl","GC_FOLDERS","height"))
		if(showFoldersArea==0)	
			SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol],GCCol[3][CurrGCCol]),linethick= 0,fillpat=1
			DrawRect/w=GraphControl 0,plotControlsY+22,plotWidth,plotControlsY+22+(SizeFoldersArea+4)
			SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),linethick= 1,fillpat=0,save
			DrawLine/w=GraphControl 0,plotControlsY+22+(SizeFoldersArea-1),plotWidth,plotControlsY+22+(SizeFoldersArea-1)
			SetDrawEnv/w=GraphControl dash=2
			DrawLine/w=GraphControl plotWidth/2-20,plotControlsY+22+(SizeFoldersArea+2),plotWidth/2+20,plotControlsY+22+(SizeFoldersArea+2)
			Button GC_FOLDERS userdata(position)=num2str(plotControlsY),win=GraphControl
		endif
		ListBox PLOT_FOLDER_LIST_LEFT,pos={1,plotControlsY+45},size={plotWidth/2-2,SizeFoldersArea-45},proc=DFSELECTListBoxProc,frame=2,win=GraphControl,disable=showFoldersArea
		ListBox PLOT_FOLDER_LIST_LEFT,listWave=root:graphcontrol:LeftFolderListText,widths={8,60},appearance={native,Win},win=GraphControl,disable=showFoldersArea
		ListBox PLOT_FOLDER_LIST_LEFT,selWave=root:graphcontrol:LeftFolderListSelect,mode= 10,win=GraphControl,disable=showFoldersArea
		ListBox PLOT_FOLDER_LIST_LEFT,colorWave=root:graphcontrol:LeftFolderListColor,win=GraphControl,disable=showFoldersArea	,focusRing=0
		ListBox PLOT_FOLDER_LIST_RIGHT,pos={2+plotWidth/2,plotControlsY+45},size={plotWidth/2-2,SizeFoldersArea-45},proc=DFSELECTListBoxProc,frame=2,win=GraphControl,disable=showFoldersArea
		ListBox PLOT_FOLDER_LIST_RIGHT,listWave=root:graphcontrol:RightFolderListText,widths={8,60},appearance={native,Win},win=GraphControl,disable=showFoldersArea
		ListBox PLOT_FOLDER_LIST_RIGHT,selWave=root:graphcontrol:RightFolderListSelect,mode= 10,win=GraphControl,disable=showFoldersArea
		ListBox PLOT_FOLDER_LIST_RIGHT,colorWave=root:graphcontrol:RightFolderListColor,win=GraphControl,disable=showFoldersArea,focusRing=0
		PopupMenu PLOT_FOLDER_PARENT_LEFT,pos={1,plotControlsY+25},size={plotWidth/2-15,25},title="Y:",bodyWidth=plotWidth/2-15,proc=DFselctecPopMenuProc,win=GraphControl,disable=showFoldersArea
		//PopupMenu PLOT_FOLDER_PARENT_LEFT,mode=1,popvalue=DF,win=GraphControl,disable=showFoldersArea
		PopupMenu PLOT_FOLDER_PARENT_RIGHT,pos={1,plotControlsY+25},size={plotWidth-2,25},title="X:",bodyWidth=plotWidth/2-15,proc=DFselctecPopMenuProc,win=GraphControl,disable=showFoldersArea
		//PopupMenu PLOT_FOLDER_PARENT_RIGHT,mode=1,popvalue=DF,win=GraphControl,disable=showFoldersArea
		SetVariable PLOT_FOLDER_CURRENTDF ,value= _STR:getdatafolder(1),pos={1,plotControlsY+SizeFoldersArea},noedit=1,frame=0,size={plotWidth-2,18},title="Current Data Folder:",win=GraphControl,disable=showFoldersArea,focusRing=0
	
		//---images---------------------------------------------------------------------
		plotControlsY+=22+(SizeFoldersArea+4)*(showFoldersArea==0)
		CurrGCCol++
		Button GC_IMAGE,pos={-4,plotControlsY},size={plotWidth+8,25},fColor=(GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),fSize=14,proc=GraphControlControlsButtonProc,title="Images",win=GraphControl
		controlinfo/w=GraphControl GC_IMAGE
		variable showImageArea=stringmatch(S_UserData,"active")	
		variable SizeImageArea=str2num(getuserdata("GraphControl","GC_IMAGE","height"))
		if(showImageArea==0)	
			SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol],GCCol[3][CurrGCCol]),linethick= 0,fillpat=1
			drawrect/w=GraphControl 0,plotControlsY+22,plotWidth,plotControlsY+22+SizeImageArea+4
			SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),linethick= 1,fillpat=0,save
			DrawLine/w=GraphControl 0,plotControlsY+22+(SizeImageArea-1),plotWidth,plotControlsY+22+(SizeImageArea-1)
			SetDrawEnv/w=GraphControl dash=2
			DrawLine/w=GraphControl plotWidth/2-20,plotControlsY+22+(SizeImageArea+2),plotWidth/2+20,plotControlsY+22+(SizeImageArea+2)
			Button GC_IMAGE userdata(position)=num2str(plotControlsY),win=GraphControl
		endif
		//---plane/recreation
		SetVariable PLOT_IMAGE_PLANE,pos={5,plotControlsY+27},size={100,18.00},proc=IMAGEPARAMS,title="Plane:",value=_num:0,win=GraphControl,disable=showImageArea
		Button PLOT_IMAGE_PLANE_PLAY,pos={105,plotControlsY+26},size={24,20},proc=IMAGEPLANEPLAY,userdata="play",title="\\W5049",win=GraphControl,disable=showImageArea
		button PLOT_IMAGE_COL_COPY,pos={155,plotControlsY+26},size={80,20},proc=IMAGECOPY,title="Color copy",win=GraphControl,disable=showImageArea
		button PLOT_IMAGE_COL_PASTE,pos={235,plotControlsY+26},size={80,20},proc=IMAGEINFOPASTE,title="Color paste",win=GraphControl,disable=showImageArea
		//---colors
		PopupMenu PLOT_IMAGE_COLOR,pos={50,plotControlsY+50},size={plotWidth*.5,19.00},bodyWidth=plotWidth*.5,value="*COLORTABLEPOPNONAMES*",proc=IMAGECOLORTABLE,title="",win=GraphControl,disable=1
		PopupMenu PLOT_IMAGE_COLOR_MINRGB,pos={5,plotControlsY+50},size={40,19.00},bodyWidth=36,value= #"\"*COLORPOP*\"",proc=IMAGECOLORTABLE,title="",win=GraphControl,disable=1
		PopupMenu PLOT_IMAGE_COLOR_MAXRGB,pos={plotWidth*.5+50,plotControlsY+50},size={40,19.00},bodyWidth=36,value= #"\"*COLORPOP*\"",proc=IMAGECOLORTABLE,title="",win=GraphControl,disable=1
		variable rightPos=120
		PopupMenu PLOT_IMAGE_COLORTABLE_NAME,pos={5,plotControlsY+50},size={50.00,17.00},proc=IMAGECOLORTABLE,win=GraphControl,disable=showImageArea
		PopupMenu PLOT_IMAGE_COLORTABLE_NAME,value= #"root:GraphControl:colortablelist",win=GraphControl,disable=showImageArea
		PopupMenu PLOT_IMAGE_COLORTABLE_TRANS,pos={265,plotControlsY+50},size={49.00,17.00},proc=IMAGECOLORTABLE,title="α",win=GraphControl,disable=showImageArea
		PopupMenu PLOT_IMAGE_COLORTABLE_TRANS,focusRing=0,value= #"\"Solid;75%;50%;25%\"",win=GraphControl,disable=showImageArea
		variable ColorTableDisplayImageTop=plotControlsY+50
		movesubwindow/w=GraphControl#ColorTableDisplayImage fnum=(rightPos+10,ColorTableDisplayImageTop,250,plotControlsY+67)
		ModifyGraph /w=GraphControl#ColorTableDisplayImage margin=-1,width=250-rightPos,height=17,nticks=0,axThick=0

		CheckBox PLOT_IMAGE_COLOR_REV,pos={325,plotControlsY+52},size={41.00,15.00},proc=IMAGECHECKPARAMS,title="Reverse",win=GraphControl,disable=showImageArea
		CheckBox PLOT_IMAGE_COLOR_MIN_AUTO,pos={10,plotControlsY+72},size={41.00,15.00},proc=IMAGECHECKPARAMS,title="Auto:",win=GraphControl,disable=showImageArea
		SetVariable PLOT_IMAGE_COLOR_MIN,pos={58,plotControlsY+70},size={80,18.00},proc=IMAGEPARAMS,title="",win=GraphControl,disable=showImageArea
		CheckBox PLOT_IMAGE_COLOR_MAX_AUTO,pos={160,plotControlsY+72},size={41.00,15.00},proc=IMAGECHECKPARAMS,title="Auto:",win=GraphControl,disable=showImageArea
		SetVariable PLOT_IMAGE_COLOR_MAX,pos={208,plotControlsY+70},size={80,18.00},proc=IMAGEPARAMS,title="",win=GraphControl,disable=showImageArea
		CheckBox PLOT_IMAGE_COLOR_LOG,pos={310,plotControlsY+72},size={41.00,15.00},proc=IMAGECHECKPARAMS,title="Log",win=GraphControl,disable=showImageArea

		PopupMenu PLOT_IMAGE_USE_COLOR_MIN,pos={10,plotControlsY+91},size={50.00,17.00},proc=IMAGECOLORTABLE,win=GraphControl,disable=showImageArea
		PopupMenu PLOT_IMAGE_USE_COLOR_MIN,value= "Use 1st;Color;Transparent",win=GraphControl,disable=showImageArea
		PopupMenu PLOT_IMAGE_USE_COLOR_MIN_COLOR,pos={100,plotControlsY+91},size={50.00,17.00},proc=IMAGECOLORTABLE,win=GraphControl,disable=showImageArea
		PopupMenu PLOT_IMAGE_USE_COLOR_MIN_COLOR,value= #"\"*COLORPOP*\"",win=GraphControl,disable=showImageArea

		PopupMenu PLOT_IMAGE_USE_COLOR_MAX,pos={160,plotControlsY+91},size={50.00,17.00},proc=IMAGECOLORTABLE,win=GraphControl,disable=showImageArea
		PopupMenu PLOT_IMAGE_USE_COLOR_MAX,value= "Use last;Color;Transparent",win=GraphControl,disable=showImageArea
		PopupMenu PLOT_IMAGE_USE_COLOR_MAX_COLOR,pos={250,plotControlsY+91},size={50.00,17.00},proc=IMAGECOLORTABLE,win=GraphControl,disable=showImageArea
		PopupMenu PLOT_IMAGE_USE_COLOR_MAX_COLOR,value= #"\"*COLORPOP*\"",win=GraphControl,disable=showImageArea


		ListBox PLOT_IMAGE_LIST,pos={1,plotControlsY+110},size={plotWidth-2,SizeImageArea-90},proc=IMAGELIST,frame=2,win=GraphControl,disable=showImageArea
		ListBox PLOT_IMAGE_LIST,listWave=root:graphcontrol:ImageListText,win=GraphControl,disable=showImageArea
		ListBox PLOT_IMAGE_LIST,titleWave=root:graphcontrol:ImageListTitle,mode= 5,win=GraphControl,disable=showImageArea
		ListBox PLOT_IMAGE_LIST,widths={100,80,100,80,80},userColumnResize= 1,win=GraphControl,disable=showImageArea
		//---trace lists---------------------------------------------------------------------
		plotControlsY+=22+(SizeImageArea+4)*(showImageArea==0)
		CurrGCCol++
		controlinfo/w=GraphControl GC_LISTS
		variable plotControlsYOld=(v_top>0)*v_top+(v_top==0)*plotControlsY
		Button GC_LISTS,pos={-4,plotControlsY},size={plotWidth+8,25},fColor=(GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol]),fSize=14,proc=GraphControlControlsButtonProc,title="Trace list",win=GraphControl
		controlinfo/w=GraphControl GC_LISTS
		SetDrawEnv/w=GraphControl  fillfgc= (GCCol[0][CurrGCCol],GCCol[1][CurrGCCol],GCCol[2][CurrGCCol],GCCol[3][CurrGCCol]),linethick= 0,fillpat=1
		drawrect/w=GraphControl 0,plotControlsY+22,plotWidth,plotHeight
		variable showListArea=stringmatch(S_UserData,"active")
		getwindow GraphControl wsize
		movewindow/w=GraphControl v_left,v_top,(v_right),(v_bottom)+(plotControlsY-plotControlsYOld)//*.75
		getwindow GraphControl wsize
		setwindow graphcontrol#colortabledisplayImage hide=(showImageArea)||(ColorTableDisplayImageTop>v_bottom-v_top-20)

		getwindow GraphControl wsizeDC
		plotHeight=v_bottom-v_top
		ListBox PLOT_TRACE_LIST,pos={1,plotControlsY+25},size={plotWidth-2,max(50,(plotHeight-plotControlsY)-30)},proc=TRACELIST,frame=2,win=GraphControl,disable=showListArea
		setdatafolder $DF
		WorkingPlotName()	
		updatetracelist(0)
		updatetracecontrols()
		updateplotparams()
		//PopulateDFLists()
		UpdateFolderColors()
		UpdateImageParameters()
	endif
	MustUpdate=0
	setdatafolder $DF
end


//****************************************PLOT********************************************************************
//****************************************PLOT********************************************************************
//****************************************PLOT********************************************************************
Function GraphControlDuplicateDF(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol
	variable/g NoUpdate=1
	dowindow/F $WorkingPlotName()
	if(stringmatch(ctrlName,"*duplicate*"))
		DoIgorMenu "Edit","Duplicate"
	endif
	doupdate
	ReplaceWave/w=$WorkingPlotName() allinCDF
	doupdate
	//print "ReplaceWave/w="+WorkingPlotName() +" allinCDF"
	//---set the axes labels
	variable i
	if(strlen(WorkingPlotName())>0)
		if(wintype(WorkingPlotName())==1)
			for(i=0;i<itemsinlist(axislist(WorkingPlotName()));i++)
				string AxName=stringfromlist(i,axislist(WorkingPlotName()))
				string AxTicks=stringbykey("userticks(x)",axisinfo(WorkingPlotName(),AxName),"=")
				if(strlen(AxTicks)>1)	//---user defined waves
					AxTicks=replacestring("}",replacestring("{",replacestring(":",AxTicks,""),""),"")
					string AxisWave=stringfromlist(0,AxTicks,",")
					string AxisWaveTxT=stringfromlist(1,AxTicks,",")
					if((strlen(AxisWave)>0)&&(strlen(AxisWaveTxT)>0))
						if((waveexists($AxisWave))&&(waveexists($AxisWaveTxT)))
							ModifyGraph/w=$WorkingPlotName() userticks($AxName)={$AxisWave,$AxisWaveTxT}
						endif
					endif
				endif
			endfor
		endif
	endif
	NoUpdate=0
	setdatafolder $DF
End

Function GraphControlEnhance(ctrlName) : ButtonControl
	String ctrlName
	ModifyGraph/w=$WorkingPlotName() btLen=2
End

Function GraphControlShowPlot(ctrlName) : ButtonControl
	String ctrlName
	dowindow/F $WorkingPlotName()
	getwindow $WorkingPlotName() wsize
	if(stringmatch(WorkingPlotName(),"*#*")==0)
		movewindow 0,0,V_right-V_left,V_bottom-V_top
	endif
End

Function GraphControlLayout(ctrlName) : ButtonControl
	String ctrlName
	AppendLayoutObject/F=0/T=1 graph $WorkingPlotName()
End
//---starts new plot
Function GraphControlNewPlot(ctrlName) : ButtonControl
	String ctrlName
	display/k=1
End

Function GraphControlControlsButtonProc(ctrlName) : ButtonControl
	String ctrlName
	controlinfo/w=GraphControl $ctrlName
	if(stringmatch(S_UserData,"active"))
		button $ctrlName,userdata="inactive",win=GraphControl
	else
		button $ctrlName,userdata="active",win=GraphControl
	endif
	GraphControlPanelUpdate(update=1)
End

//---events that happen when graphcontrol panel is activated or resized
function GraphControlPanelHook(s)
	STRUCT WMWinHookStruct &s
	string DF=getdatafolder(1)
	dowindow GraphControl
	if(v_flag)
		setdatafolder root:graphcontrol:		
		nvar/z MustUpdate,noUpdate
		if(exists("MustUpdate")==0)
			variable/g MustUpdate=0
		endif
		if(exists("noUpdate")==0)
			variable/g noUpdate=1
		endif
		if(noUpdate==0)	
			if ((s.eventcode<=2)&&(strlen(WorkingPlotName())))//activate//kill
				MustUpdate=1
			endif
			if ((s.eventcode==0)&&(strlen(winname(0,64))))//activate	 GraphControl
				MustUpdate=1
			endif
			if ((s.eventcode==6)&&(strlen(winname(0,64))))//resize GraphControl
				getwindow GraphControl wsize
				if(V_bottom-V_top<200)
					MoveWindow /w=GraphControl V_left,V_top,V_right,V_top+200
				endif
				MustUpdate=1
			endif
			//----folder tab size change
			variable ActiveFoldersArea=stringmatch((getuserdata("GraphControl","GC_FOLDERS","")),"active")
			variable PosFoldersArea=str2num(getuserdata("GraphControl","GC_FOLDERS","position"))
			variable HeightFoldersArea=str2num(getuserdata("GraphControl","GC_FOLDERS","height"))
			s.doSetCursor=0
			if(ActiveFoldersArea==0)
				if( abs(s.mouseLoc.v-(PosFoldersArea+HeightFoldersArea+22))<4)//---over folder selector
					s.doSetCursor=1
					s.cursorCode=6
					if (s.eventCode==3)//mouse down
						Button GC_FOLDERS userdata(mousemoving)="moving",win=GraphControl
					endif
				endif
				if (s.eventCode==4)//mouse moving
					if (stringmatch(getuserdata("GraphControl","GC_FOLDERS","mousemoving"),"moving"))
						Button GC_FOLDERS userdata(height)=num2str(max(s.mouseLoc.v-PosFoldersArea-22,70)),win=GraphControl
						//GraphControlPanelUpdate()
						MustUpdate=1
					endif
				endif			
				if (s.eventCode==5)//mouse up
					Button GC_FOLDERS userdata(mousemoving)="",win=GraphControl
				endif
			endif
			//----images tab size change
			variable ActiveImagesArea=stringmatch((getuserdata("GraphControl","GC_IMAGE","")),"active")
			variable PosImagesArea=str2num(getuserdata("GraphControl","GC_IMAGE","position"))
			variable HeightImagesArea=str2num(getuserdata("GraphControl","GC_IMAGE","height"))
			if(ActiveImagesArea==0)
				if( abs(s.mouseLoc.v-(PosImagesArea+HeightImagesArea+22))<4)//---over folder selector
					s.doSetCursor=1
					s.cursorCode=6
					if (s.eventCode==3)//mouse down
						Button GC_IMAGE userdata(mousemoving)="moving",win=GraphControl
					endif
				endif
				if (s.eventCode==4)//mouse moving
					if (stringmatch(getuserdata("GraphControl","GC_IMAGE","mousemoving"),"moving"))
						Button GC_IMAGE userdata(height)=num2str(max(s.mouseLoc.v-PosImagesArea-22,140)),win=GraphControl
						MustUpdate=1
					endif
				endif			
				if (s.eventCode==5)//mouse up
					Button GC_IMAGE userdata(mousemoving)="",win=GraphControl
				endif
			endif	
			if(MustUpdate)
				//print getdatafolder(1)
				execute/p/q "GraphControlPanelUpdate()"
			endif
		endif	//---no update
	
		setdatafolder $DF
	endif
End
//---the graphs are now lnked to graphcontrol panel
function GraphControlHook(s)
	STRUCT WMWinHookStruct &s
	string DF=getdatafolder(1)
	dowindow GraphControl
	if(v_flag)
		setdatafolder root:graphcontrol:		
		nvar MustUpdate	
		if ((s.eventcode==6)||(s.eventcode==0)||(s.eventcode==2))//||((s.eventcode==8)))//||(s.eventcode==8))//||(s.eventcode==15)||(s.eventcode==16))
			MustUpdate=1
		endif
		setdatafolder $DF
		
	//	execute/p/q "GraphControlPanelUpdate()"
	endif
End

//---update of the axis and plot controls
function UpdatePlotParams()
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:		
	svar axisleft,axisbottom
	variable updatelabel=0,vmin,vmax
	string labelname,tickstr
	dowindow GraphControl
	if(v_flag)
		if(strlen(WorkingPlotName())>0)
			if(wintype(WorkingPlotName())==1)
				getwindow $WorkingPlotName() gsize
				variable left=v_left,right=v_right,top=v_top,bottom=v_bottom
				getwindow $WorkingPlotName() psize
				left+=v_left;right-=v_right;top+=v_top;bottom-=v_bottom
				setvariable PLOT_MARGIN_LEFT value=_NUM:round(left),win=GraphControl
				setvariable PLOT_MARGIN_RIGHT value=_NUM:round(right),win=GraphControl
				setvariable PLOT_MARGIN_TOP value=_NUM:round(top),win=GraphControl
				setvariable PLOT_MARGIN_BOTTOM value=_NUM:round(bottom),win=GraphControl
				setvariable PLOT_SIZEW value=_NUM:round(v_right-v_left),win=GraphControl
				setvariable PLOT_SIZEH value=_NUM:round(v_bottom-v_top),win=GraphControl
				SetVariable PLOT_NAME value=_STR:WorkingPlotName(),win=GraphControl
				string recreation= winrecreation(WorkingPlotName(),0)
				CheckBox PLOT_SWAPXY value=stringmatch(recreation,"*swapXY=1*"), win=GraphControl
				if(strlen(stringbykey("expand",recreation,"=",",")))
					SetVariable PLOT_EXPAND value=_NUM:abs(numberbykey("expand",recreation,"=",",")),win=GraphControl
				else
					SetVariable PLOT_EXPAND value=_NUM:1,win=GraphControl
				endif
		
				variable axistype
				string axistST="left"
				for(axistype=0;axistype<=1;axistype++)
					if(axistype==1)
						axistST="bottom"
					endif	
					ComputePerUnit("PLOT_PERUNIT_AXIS_"+axistST)
					controlinfo/w=GraphControl $"PLOT_AXIS_"+axistST
					getaxis/w=$WorkingPlotName()/q $S_value
					labelname=S_value
	//print labelname,"ok"
					if((strlen(labelname)>0)&&(V_disable==0))
						updatelabel+=((stringmatch(s_value,AxisLabel(WorkingPlotName(),labelname))==0))
						execute "popupmenu PLOT_AXIS_COLOR_"+axistST +" popcolor="+stringbykey("axrgb(x)",axisinfo(WorkingPlotName(),labelname),"=")+",win=GraphControl"
						SetVariable $"PLOT_"+axistST+"_MIN" value=_NUM:V_min,size={round(strlen(num2str(v_min))*6+30),18},win=GraphControl
						SetVariable $"PLOT_"+axistST+"_MAX" value=_NUM:V_max,size={round(strlen(num2str(v_max))*6+30),18},win=GraphControl
						checkbox $"PLOT_"+axistST+"_MODE_LINEAR" value=(numberbykey("log(x)",axisinfo(WorkingPlotName(),labelname),"=")==0),win=GraphControl
						checkbox $"PLOT_"+axistST+"_MODE_LOG" value=(numberbykey("log(x)",axisinfo(WorkingPlotName(),labelname),"=")==1),win=GraphControl
						checkbox $"PLOT_"+axistST+"_MODE_LOG2" value=(numberbykey("log(x)",axisinfo(WorkingPlotName(),labelname),"=")==2),win=GraphControl
						checkbox $"PLOT_"+axistST+"_MODE_ZERO" value=(numberbykey("zero(x)",axisinfo(WorkingPlotName(),labelname),"=")),win=GraphControl
						SetVariable $"PLOT_"+axistST+"_LABEL" value=_str:AxisLabel(WorkingPlotName(),labelname),win=GraphControl
						//print axisinfo(WorkingPlotName(),labelname)
						//---ticks
						tickstr=stringbykey("manTick(x)",axisinfo(WorkingPlotName(),s_value),"=")
						SetVariable $"PLOT_"+axistST+"_TICKS",disable=1,win=GraphControl,value=_num:numberbykey("nticks(x)",axisinfo(WorkingPlotName(),labelname),"=")
						SetVariable $"PLOT_"+axistST+"_TICKSINC",disable=1,win=GraphControl,value=_num:str2num(stringfromlist(1,tickstr,","))
						SetVariable $"PLOT_"+axistST+"_TICKSSTART",disable=1,win=GraphControl,value=_num:str2num(replacestring("{",stringfromlist(0,tickstr,","),""))
						SetVariable $"PLOT_"+axistST+"_TICKSMINOR",disable=1,win=GraphControl,value=_num:str2num(replacestring("manMinor(x)={",stringfromlist(4,tickstr,","),""))
						//---distance
						string distST= removeending(replacestring("{",stringbykey("freepos(x)",axisinfo(WorkingPlotName(),labelname),"=")	,""))
						if(strlen(distST)==0)
							distST="0"
						endif
				//print distST
						SetVariable $"PLOT_"+axistST+"_DISTANCE",win=GraphControl,value=_num:str2num(stringfromlist(0,distST))//,disable=(strlen(distST)==0)
						
						//---axis enabled
						SetVariable $"PLOT_"+axistST+"_DRAWMIN",win=GraphControl,value=_num:str2num(stringfromlist(0,removeending(replacestring("{",stringbykey("axisenab(x)",axisinfo(WorkingPlotName(),labelname),"="),"")),","))*100
						SetVariable $"PLOT_"+axistST+"_DRAWMAX",win=GraphControl,value=_num:str2num(stringfromlist(1,removeending(replacestring("{",stringbykey("axisenab(x)",axisinfo(WorkingPlotName(),labelname),"="),"")),","))*100
						//---category axis		
						if (numberbykey("ISCAT",AxisInfo(WorkingPlotName(), labelname),":"))	//---category
							string catwave=stringbykey("HOOK",AxisInfo(WorkingPlotName(), labelname),":")+stringbykey("CATWAVE",AxisInfo(WorkingPlotName(), labelname),":")
							getwindow graphcontrol wsizeDC
							SetVariable $"PLOT_"+axistST+"_TICKS",size={(v_right-v_left)-95,15},value=_str:catwave,win=GraphControl
						else
							SetVariable $"PLOT_"+axistST+"_TICKS",size={80,15},value=_num:numberbykey("nticks(x)",axisinfo(WorkingPlotName(),labelname),"="),win=GraphControl
						endif
						controlinfo/w=GraphControl GC_AXES
						if(stringmatch(S_UserData,"inactive"))		
							if(strlen(stringbykey("manTick(x)",axisinfo(WorkingPlotName(),labelname),"="))==1)
								button $"PLOT_"+axistST+"_AUTO_TICKS",userdata="manual",title="Auto ticks",win=GraphControl	
								SetVariable $"PLOT_"+axistST+"_TICKS",disable=0,win=GraphControl
							else
								button $"PLOT_"+axistST+"_AUTO_TICKS",userdata="auto",title="Manual ticks",win=GraphControl
								SetVariable $"PLOT_"+axistST+"_TICKSSTART",disable=0,win=GraphControl	
								SetVariable $"PLOT_"+axistST+"_TICKSINC",disable=0,win=GraphControl
								SetVariable $"PLOT_"+axistST+"_TICKSMINOR",disable=0,win=GraphControl
							endif
						endif			
						CheckBox $"TRANS_HIDE_"+axistST ,win=GraphControl,value=((numberbykey("nticks(x)",axisinfo(WorkingPlotName(),labelname),"=")+numberbykey("axThick(x)",axisinfo(WorkingPlotName(),labelname),"="))==0)
					else	//---no axis
						modifycontrollist ControlNameList("GraphControl", ";", "PLOT_LEFT*") disable=1,win=GraphControl 
						modifycontrollist ControlNameList("GraphControl", ";", "PLOT_BOTTOM*") disable=1,win=GraphControl 
					endif
				endfor
			endif	
		else //---no plots
			modifycontrollist ControlNameList("GraphControl", ";", "PLOT_LEFT*") disable=1,win=GraphControl 
			modifycontrollist ControlNameList("GraphControl", ";", "PLOT_BOTTOM*") disable=1,win=GraphControl 
			SetVariable PLOT_NAME value=_STR:"",win=GraphControl
			CheckBox PLOT_SWAPXY value=0, win=GraphControl
			SetVariable PLOT_EXPAND value=_NUM:0,win=GraphControl			
		endif
	endif	//---no graphcontrol
	setdatafolder DF
end

//---copies the plot and axis information
Function PLOTINFOCOPY(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	make/o/n=6 plotval
	make/t/o/n=(0,3) axesval
	variable i
	for (i=0;i<itemsinlist(AxisList(WorkingPlotName() ));i+=1)
		insertpoints/m=0 0,1, axesval
		axesval[0][0]=stringfromlist(i,axislist(WorkingPlotName()))
		axesval[0][1]=AxisInfo(WorkingPlotName(), axesval[0][0])
		axesval[0][2]=AxisLabel(WorkingPlotName(),axesval[0][0])
	endfor	
	controlinfo /w=GraphControl PLOT_MARGIN_LEFT
	plotval[0]=v_value
	controlinfo /w=GraphControl PLOT_MARGIN_RIGHT
	plotval[1]=v_value
	controlinfo /w=GraphControl PLOT_MARGIN_TOP
	plotval[2]=v_value
	controlinfo /w=GraphControl PLOT_MARGIN_BOTTOM
	plotval[3]=v_value
	controlinfo /w=GraphControl PLOT_SIZEW
	plotval[4]=v_value
	controlinfo /w=GraphControl PLOT_SIZEH
	plotval[5]=v_value		
	setdatafolder DF
End
//---paste plot and axis information
Function PLOTINFOPASTE(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	wave plotval
	wave/t  axesval	
	variable i,items
	for (i=0;i<dimsize(axesval,0);i+=1)	
		if (whichlistitem(axesval[i][0],AxisList(WorkingPlotName() ))>=0)//axis exists
			execute/q stringbykey("SETAXISCMD", axesval[i][1],":")
			string info=axesval[i][1]
			string recreation=replacestring("RECREATION:",info[strsearch(info,"RECREATION",0),strlen(info)-1],"")
			for (items=0;items<itemsinlist(recreation);items+=1)
				execute/q "ModifyGraph /w="+WorkingPlotName()+" "+ReplaceString("(x)",stringfromlist(items,recreation),"("+axesval[i][0]+")",1)	
			endfor	
			execute /p "label /w="+WorkingPlotName()+" " + axesval[i][0]+" \""+ replacestring("\\", axesval[i][2],"\\")+"\""
		endif
	endfor
	ModifyGraph/w=$WorkingPlotName() margin(left)=plotval[0],margin(right)=plotval[1],margin(top)=plotval[2],margin(bottom)=plotval[3],width=plotval[4],height=plotval[5]
	setdatafolder DF
End
//****************************************AXES********************************************************************
//****************************************AXES********************************************************************
//****************************************AXES********************************************************************
//---changes plot label
Function PLOT_LABEL(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	if(stringmatch(ctrlName,"*bottom*"))
		controlinfo/w=GraphControl PLOT_AXIS_BOTTOM
	else
		controlinfo/w=GraphControl PLOT_AXIS_LEFT
	endif
	getaxis/w=$WorkingPlotName()/q $S_value	
 	label $S_value varStr 
End

//---selection of an axis
Function PLOTAXISSEL(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	if (stringmatch(ctrlName,"*_COLOR*"))//---color
		string axistST="left"
		if( stringmatch(ctrlName,"*bottom*"))
			axistST="bottom"
		endif	
		controlinfo/w=GraphControl $"PLOT_AXIS_"+axistST
		string CurrAxis=S_value
		controlinfo/w=graphcontrol $ctrlName
		execute "ModifyGraph/w="+WorkingPlotName()+" axRGB("+CurrAxis+")="+S_Value+" ,tlblRGB("+CurrAxis+")="+S_Value+" ,alblRGB("+CurrAxis+")="+S_Value
	endif
	updateplotparams()
	
End

//---sets axis 
Function AUTOAXIS(ctrlName) : ButtonControl
	String ctrlName
	if((stringmatch(ctrlName,"*left*")))
		controlinfo/w=GraphControl PLOT_AXIS_LEFT
	else
		controlinfo/w=GraphControl PLOT_AXIS_BOTTOM
	endif
	getaxis/w=$WorkingPlotName()/q $S_value
	if((stringmatch(ctrlName,"*auto*")))	
		string printST= "setaxis /w="+WorkingPlotName()+" "+S_value+" *,*"//+num2str(v_max)
		controlinfo/w=GraphControl PLOT_PRINT
		if(v_value)
			execute/p printST
		else
			execute/q printST
		endif
		string DF=getdatafolder(1)
		setdatafolder root:graphcontrol:	
		nvar MustUpdate
		MustUpdate=1
		execute/p/q "GraphControlPanelUpdate()"
		setdatafolder $DF
	endif
End

//---hides or shows the selected axis
Function AXISHIDE(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	if((stringmatch(ctrlName,"*left*")))
		controlinfo/w=GraphControl PLOT_AXIS_LEFT
	else
		controlinfo/w=GraphControl PLOT_AXIS_BOTTOM
	endif
	if(checked)
		string printST= "ModifyGraph/w="+WorkingPlotName()+" nticks("+S_value+")=0,axThick("+S_value+")=0"
	else
		printST= "ModifyGraph /w="+WorkingPlotName()+" nticks("+S_value+")=2,axThick("+S_value+")=1"
	endif
	controlinfo/w=GraphControl PLOT_PRINT
	if(v_value)
		execute/p printST
	else
		execute/q printST
	endif
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	nvar MustUpdate
	MustUpdate=1
	execute/p/q "GraphControlPanelUpdate()"
	setdatafolder $DF	
End

//---selects the vertical or the horizontal axes
function/s getaxistype(left0bottom1)
	variable left0bottom1
	variable i
	string result=""
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:	
	if(strlen(WorkingPlotName())>0)
		if(wintype(WorkingPlotName())==1)
			for(i=0;i<itemsinlist(axislist(WorkingPlotName()));i+=1)
				if((stringmatch( stringbykey("AXTYPE",AxisInfo(WorkingPlotName(), stringfromlist(i,axislist(WorkingPlotName()))) ,":"),"*left*")) ||(stringmatch( stringbykey("AXTYPE",AxisInfo(WorkingPlotName(), stringfromlist(i,axislist(WorkingPlotName()))) ,":"),"*right*")))
					if(left0bottom1==0)
						result+=stringfromlist(i,axislist(WorkingPlotName()))+";"
					endif
				endif
				if((stringmatch( stringbykey("AXTYPE",AxisInfo(WorkingPlotName(), stringfromlist(i,axislist(WorkingPlotName()))) ,":"),"*bottom*")) ||(stringmatch( stringbykey("AXTYPE",AxisInfo(WorkingPlotName(), stringfromlist(i,axislist(WorkingPlotName()))) ,":"),"*top*")))
					if(left0bottom1==1)
						result+=stringfromlist(i,axislist(WorkingPlotName()))+";"
					endif
				endif
			endfor
			//---make sure that there is next axis to increment
			i=0
			
			if(left0bottom1==0)
				string axis0="left",axis1="right"
			else
				axis0="top",axis1="bottom"
			endif
			string axiscompare=axis0
			do
				if(i>0)
					axiscompare=axis0+num2str(i)
				endif
				i++
			while(whichlistitem(axiscompare,result)>=0)
			result+=axiscompare+";"
			axiscompare=axis1
			i=0
			do
				if(i>0)
					axiscompare=axis1+num2str(i)
				endif
				i++
			while(whichlistitem(axiscompare,result)>=0)
			result+=axiscompare+";"			
		endif
	endif
	
	if(datafolderExists(DF))
		setdatafolder $DF
	endif
	return result
end

//---find the label of the axis
Function/S AxisLabel(graphName, axisName, [SuppressEscaping])
	String graphName, axisName
	Variable SuppressEscaping
	
	if (ParamIsDefault(SuppressEscaping))
		SuppressEscaping = 0
	endif	
	String axisLabelST=""
	String info= WinRecreation(graphName,04)
	Variable start= strsearch(info, "Label "+axisName+" ", 0)
	if( start >= 0 )
		start = strsearch(info, "\"", start)+1
		Variable theEnd= strsearch(info, "\"", start)-1
		axisLabelST= info[start,theEnd]
	endif
	if (SuppressEscaping)
		start = 0
		do
			start = strsearch(axisLabelST, "\\\\", start)	// search for double backslash
			if (start >= 0)
				string newLabel = axisLabelST[0,start-1]
				newLabel += axisLabelST[start+1, strlen(axisLabelST)-1]
				axisLabelST = newLabel
			else
				break
			endif
		while(1)
	endif
	return axisLabelST
End

//---sets the manual ticks
function SETMANUALTICKS(AxisName)
	string AxisName
	controlinfo/w=GraphControl $"PLOT_AXIS_"+AxisName
	getaxis/w=$WorkingPlotName()/q $S_value
	string axis=s_value
	controlinfo/w=GraphControl $"PLOT_"+AxisName+"_TICKSSTART"
	string tickstart=num2str(v_value)
	controlinfo/w=GraphControl $"PLOT_"+AxisName+"_TICKSINC"
	variable tickinc=(v_value),tickval=abs(mod(v_value,1))
	variable dot=0
	if(tickval>0)
		do
			if(tickval>=1)
				break
			endif
			dot++
			tickval*=10
		while(1)
	endif
	string printST="ModifyGraph/w="+WorkingPlotName()+" manTick("+axis+")={"+tickstart+","+num2str(tickinc)+",0,"+num2str(dot)+"}"
	controlinfo/w=GraphControl PLOT_PRINT
	if(v_value)
		execute/p printST
	else
		execute/q printST
	endif
end

//---selects ticks-auto or manual
Function PLOTAXISTICKs(ctrlName) : Buttoncontrol
	String ctrlName
	string AxisName="bottom"
	if(stringmatch(ctrlname,"*left*"))
		AxisName="left"
	endif
	controlinfo/w=GraphControl $"PLOT_AXIS_"+AxisName
	getaxis/w=$WorkingPlotName()/q $S_value
	string axis=s_value
	string info=AxisInfo(WorkingPlotName(), axis)
	if (numberbykey("ISCAT",info,":"))	//---category
		button $ctrlName,userdata="manual",title="Auto ticks",win=GraphControl
		ModifyGraph /w=$WorkingPlotName() manTick($axis)=0
	else
		if	(stringmatch(getuserdata("GraphControl",ctrlName,""),"auto"))
			button $ctrlName,userdata="manual",title="Auto ticks",win=GraphControl
			string printST="ModifyGraph/w="+WorkingPlotName()+" manTick("+axis+")=0"
			controlinfo/w=GraphControl PLOT_PRINT
			if(v_value)
				execute/p printST
			else
				execute/q printST
			endif
		else
			button $ctrlName,userdata="auto",title="Manual ticks",win=GraphControl
			SETMANUALTICKS(AxisName)
		endif
	endif
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	nvar MustUpdate
	MustUpdate=1
	execute/p/q "GraphControlPanelUpdate()"
	setdatafolder $DF	
end

//---selects a new axis mode -linear,log,log2
Function PLOTAXISMODE(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked	
	string axname="BOTTOM"
	controlinfo/w=GraphControl PLOT_AXIS_BOTTOM
	if(stringmatch(ctrlName,"PLOT_SWAPXY"))
		string printST= "ModifyGraph/w="+WorkingPlotName()+" swapXY="+num2str(checked)
	else
		if (stringmatch(ctrlName,"*LEFT*"))
			axname="LEFT"
		endif
		controlinfo/w=GraphControl $"PLOT_AXIS_"+axname
		if(stringmatch(ctrlName,"*STANDOFF*"))
			printST= "ModifyGraph/w="+WorkingPlotName()+" standoff("+s_value+")="+num2str(checked)
		elseif(stringmatch(ctrlName,"*zero"))
			printST= "ModifyGraph/w="+WorkingPlotName()+" zero("+s_value+")="+num2str(checked)

		else				
			CheckBox $"PLOT_"+axname+"_MODE_LINEAR" value=0,win=GraphControl
			CheckBox $"PLOT_"+axname+"_MODE_LOG" value=0,win=GraphControl
			CheckBox $"PLOT_"+axname+"_MODE_LOG2" value=0,win=GraphControl
			CheckBox $ctrlName value=1,win=GraphControl
			printST="ModifyGraph/w="+WorkingPlotName()+" log("+s_value+")=0"		
			if(stringmatch(ctrlName,"*log"))
				printST ="ModifyGraph/w="+WorkingPlotName()+" log("+s_value+")=1"
			endif
			if(stringmatch(ctrlName,"*log2"))
				printST= "ModifyGraph/w="+WorkingPlotName()+" log("+s_value+")=2"
			endif
		endif
	endif
	controlinfo/w=GraphControl PLOT_PRINT
	if(v_value)
		execute/p printST
	else
		execute/q printST
	endif	
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	nvar MustUpdate
	MustUpdate=1
	execute/p/q "GraphControlPanelUpdate()"
	setdatafolder $DF	
End

//---update of the plot and axis parameters
Function PLOTSIZE(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	variable minval,maxval
	string printST="",st
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	svar PlotName
	nvar MustUpdate
	setdatafolder $DF
	if(stringmatch(ctrlName,"plot_name"))
		printST="DoWindow/C /W=" +PlotName+" "+varstr+";DoWindow/T GraphControl,\"Graph Contol - "+varstr+"\""
	endif
	
	string margins="left;right;top;bottom"
	variable i
	for(i=0;i<itemsinlist(margins);i++)
		if(stringmatch(ctrlName,"PLOT_MARGIN_"+stringfromlist(i,margins)))
			printST="ModifyGraph/w="+WorkingPlotName()+" margin("+stringfromlist(i,margins)+")="+varstr
		endif
	endfor
	if(stringmatch(ctrlName,"PLOT_MARGIN_ALL"))
		printST="ModifyGraph/w="+WorkingPlotName()+" margin="+varstr
	endif
	
	if(stringmatch(ctrlName,"PLOT_SIZEH"))
		ComputePerUnit("PLOT_PERUNIT_AXIS_LEFT")
		printST="ModifyGraph/w="+WorkingPlotName()+" height="+varstr
	endif		
	if(stringmatch(ctrlName,"PLOT_SIZEW"))
		ComputePerUnit("PLOT_PERUNIT_AXIS_BOTTOM")
		printST="ModifyGraph/w="+WorkingPlotName()+" width="+varstr
	endif
	if(stringmatch(ctrlName,"PLOT_PERUNIT_SIZEH"))
		controlinfo/w=GraphControl PLOT_AXIS_LEFT
		getaxis/w=$WorkingPlotName()/q $S_value
		printST="ModifyGraph/w="+WorkingPlotName()+" height={perUnit,"+(varstr)+","+S_value+"}"
	endif
	if(stringmatch(ctrlName,"PLOT_PERUNIT_SIZEW"))
		controlinfo/w=GraphControl PLOT_AXIS_BOTTOM
		getaxis/w=$WorkingPlotName()/q $S_value
		printST="ModifyGraph/w="+WorkingPlotName()+" width={perUnit,"+(varstr)+","+S_value+"}"
	endif	
	if(stringmatch(ctrlName,"PLOT_EXPAND"))
		printST="ModifyGraph/w="+WorkingPlotName()+" expand="+varstr
	endif		
	if(((stringmatch(ctrlName,"*LEFT*"))||(stringmatch(ctrlName,"*BOTTOM*")))&&(stringmatch(ctrlName,"*MARGIN*")==0))
		string axname="BOTTOM",oppaxname="LEFT"
		if (stringmatch(ctrlName,"*LEFT*"))
			axname="LEFT"
			oppaxname="BOTTOM"
		endif	
		if(stringmatch(ctrlName,"plot_*_max"))
			controlinfo/w=GraphControl $"PLOT_AXIS_" + axname
			getaxis/w=$WorkingPlotName()/q $S_value
			printST="SetAxis /w="+WorkingPlotName()+ " "+S_value+" "+num2str(V_min)+" ,"+varstr
		endif	
		if(stringmatch(ctrlName,"plot_*_min"))
			controlinfo/w=GraphControl $"PLOT_AXIS_" + axname
			getaxis/w=$WorkingPlotName()/q $S_value
			printST="SetAxis/w="+WorkingPlotName()+" "+S_value+" "+varstr+","+num2str(V_max)
		endif			
		//---ticks
		if(stringmatch(ctrlName,"PLOT_*_TICKS"))
			controlinfo/w=GraphControl $"PLOT_AXIS_" + axname
			getaxis/w=$WorkingPlotName()/q $S_value
			if(numtype(str2num(varstr))==0)	//---ticks
				printST="ModifyGraph/w="+WorkingPlotName()+" nticks("+S_value+")="+varstr
			else
				printST="edit/k=1 "+varstr	//---category plot
			endif
		endif	
		if((stringmatch(ctrlName,"PLOT_*_TICKSINC")) || (stringmatch(ctrlName,"PLOT_*_TICKSSTART")) )
			SETMANUALTICKS(axname)	
		endif	
		if(stringmatch(ctrlName,"PLOT_*_TICKSMINOR"))
			controlinfo/w=GraphControl $"PLOT_AXIS_" + axname
			getaxis/w=$WorkingPlotName()/q $S_value
			printST="ModifyGraph/w="+WorkingPlotName()+" manMinor("+S_value+")={"+varstr+",0}"
		endif
		if(stringmatch(ctrlName,"PLOT_*_DRAW*"))
			controlinfo/w=GraphControl $"PLOT_"+axname+"_DRAWMIN"
			variable drawMIN=v_value
			controlinfo/w=GraphControl $"PLOT_"+axname+"_DRAWMAX"
			variable drawMAX=v_value
			controlinfo/w=GraphControl $"PLOT_AXIS_" + axname
			getaxis/w=$WorkingPlotName()/q $S_value	
			drawMIN=min(100,max(0,drawMIN))
			drawMAX=min(100,max(0,drawMAX))
			drawMAX=max(drawMAX,drawMIN+1)
			printST="ModifyGraph axisEnab("+S_value+")={"+num2str(drawMIN/100)+","+num2str(drawMAX/100)+"}"
		endif
		if(stringmatch(ctrlName,"PLOT_*_DISTANCE"))
			controlinfo/w=GraphControl  $"PLOT_AXIS_" + oppaxname
			getaxis/w=$WorkingPlotName()/q $S_value
			string oppositeAxis=s_value
			controlinfo/w=GraphControl  $"PLOT_AXIS_" + axname
			
			getaxis/w=$WorkingPlotName()/q $S_value
			if(stringmatch(varstr,"0"))
				printST="ModifyGraph/w="+WorkingPlotName()+" freepos("+S_value+")=0"
			else
				printST="ModifyGraph/w="+WorkingPlotName()+" freepos("+S_value+")={"+varstr+","+oppositeAxis+"}"
			endif
		endif	
		if(stringmatch(ctrlName,"PLOT_*_TICKS"))
			controlinfo/w=GraphControl $"PLOT_AXIS_" + axname
			getaxis/w=$WorkingPlotName()/q $S_value
			if(numtype(str2num(varstr))==0)	//---ticks
				printST="ModifyGraph/w="+WorkingPlotName()+" nticks("+S_value+")="+varstr
			else
				printST="edit/k=1 "+varstr	//---category plot
			endif
		endif			
	endif		
	//---run the command
	if (strlen(WorkingPlotName()))			
		controlinfo/w=GraphControl PLOT_PRINT
		if(v_value)
			execute/p printST
		else
			execute/q printST
		endif	
	endif
	MustUpdate=1
	execute/p/q "GraphControlPanelUpdate()"
	setdatafolder $DF	
End

//---estimation of the perunit size
function ComputePerUnit(axiscontrol)
	string axiscontrol
	variable bottom=stringmatch(axiscontrol,"*bottom*")
	getwindow $WorkingPlotName() psize
	string sizecontrol="PLOT_SIZEH"
	string persizecontrol="PLOT_PERUNIT_SIZEH"
	variable windowsize=round(v_bottom-v_top)
	if(bottom)
		sizecontrol="PLOT_SIZEW"
		persizecontrol="PLOT_PERUNIT_SIZEW"
		windowsize=round(v_right-v_left)
	endif
	string CurrentAxisString=getaxistype(bottom)
	if(strlen(CurrentAxisString))	//---there are axes that can be used
		controlinfo/w=GraphControl $axiscontrol
		getaxis/w=$WorkingPlotName()/q $stringfromlist(min(v_value-1,itemsinlist(CurrentAxisString)-1),CurrentAxisString)	//---get the current axis
		variable axisminmax=abs(v_max-v_min)
		if(axisminmax>0)	//---the axis is larger than zero
			SetVariable $persizecontrol value=_num:windowsize/axisminmax,win=GraphControl
		else
			SetVariable $persizecontrol value=_num:0,win=GraphControl
		endif
	else
		popupmenu  $axiscontrol, popvalue="_none_",win=GraphControl
	endif
end

//---per unit axis changes
Function PLOTAXISSIZEPopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	ComputePerUnit(ctrlName)
End

//****************************************ERROR BARS********************************************************************
//****************************************ERROR BARS********************************************************************
//****************************************ERROR BARS********************************************************************
//--------------------error bars functions----------------------//
function/s EBdata(type,help)
	string type,help
	help=stringbykey(type,help,"=",";")
	help=replacestring("(",help,"")
	help=replacestring(")",help,"")	
	return help
end
	
//---returns the list of waves in the current folder that math the length of the trace
function/s FindErrorWavesFolder()
	string foundwaves="_none_"
	if(gettracenumber(-1)>=0)
		variable tracepnts=dimsize(WaveRefIndexed(WorkingPlotName(), gettracenumber(-1),1),0)
		variable w
		for(w=0;w<countobjects(getdatafolder(1),1);w++)
			if(dimsize($GetIndexedObjName(getdatafolder(1),1,w),0)==tracepnts)
				foundwaves+=";"+GetIndexedObjName(getdatafolder(1),1,w)
			endif
		endfor
	endif
	return foundwaves

end


//---update error bars according to selected trace
function readEB(info,tracename,docapbar)
	string info,tracename
	variable docapbar
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:		
	svar disablelist
	setdatafolder DF
	string st,yp="",yn="",xp="",xn="",help=""
	st=stringbykey("ERRORBARS",info,":",";")
//print st
	st=replacestring("ERRORBARS",st,"")	
	if(docapbar)
		if(numtype(numberbykey("/T",st,"="))==0)
			SetVariable ERROR_CAPH value=_num:numberbykey("/T",st,"="),win=GraphControl
		endif
		if(numtype(numberbykey("/Y",st,"="))==0)
			SetVariable ERROR_CAPW value=_num:numberbykey("/Y",st,"="),win=GraphControl
		endif
		if(numtype(numberbykey("/L",st,"="))==0)
			SetVariable ERROR_BAR value=_num:numberbykey("/L",st,"="),win=GraphControl
		endif
	endif
	variable alpha=256
	string EBcolor=stringfromlist(2,st,",")+","+stringfromlist(3,st,",")+","+stringfromlist(4,st,",")
	if((stringmatch(stringfromlist(4,st,","),"*)*")==0)&&(stringmatch(st,"*SHADE*")>0))
		EBcolor+=")"
		alpha=str2num(removeending(stringfromlist(5,st,",")))/(256)
	endif
	if((stringmatch(st,"*SHADE*")==0))
		disablelist+= "ERROR_TRANS_SHADE;ERROR_SHADE_EB;" 
	endif
	SetVariable ERROR_TRANS_SHADE win=graphcontrol,value= _NUM:alpha
	 
	st=replacestring(tracename+" ",st,"")
	if(stringmatch(st,"*shade*"))
		CheckBox ERROR_SHADE value= 1,win=graphcontrol
		variable del=strsearch(st,"wave",0)
		st=replacestring(st[0,del-1],st,"")
		st=replacestring("wave",st,"ywave",0,1)	
		disablelist+="ERROR_CAPW;"
		disablelist+="ERROR_CAPH;"
		disablelist+="ERROR_BAR;"
		execute "popupmenu ERROR_SHADE_EB popColor="+EBcolor+" ,win=GraphControl"
	else
		CheckBox ERROR_SHADE value= 0,win=graphcontrol
		del=strsearch(st," X",0)
		if(del==-1)
			del=strsearch(st," Y",0)
		endif
		st=replacestring(st[0,del-1],st,"")
	
		if (stringmatch(st," XY*"))
			st=replacestring(",wave",st,";xwave",0,1)	
			st=replacestring(",wave",st,";ywave",0,1)	
		else
			if (stringmatch(st," Y*"))
				st=replacestring(",wave",st,";ywave",0,1)	
			else			
				st=replacestring(",wave",st,";xwave",0,1)	
			endif
		endif
	endif
	SetVariable ERROR_YP value=_str:EBdata("ywave",st),win=GraphControl
	SetVariable ERROR_XP value=_str:EBdata("xwave",st),win=GraphControl
	popupmenu ERROR_NEW_YP mode=1+whichlistitem(stringfromlist(0,EBdata("ywave",st),","),FindErrorWavesFolder()),win=GraphControl
	popupmenu ERROR_NEW_YN mode=1+whichlistitem(stringfromlist(1,EBdata("ywave",st),","),FindErrorWavesFolder()),win=GraphControl
	popupmenu ERROR_NEW_XP mode=1+whichlistitem(stringfromlist(0,EBdata("xwave",st),","),FindErrorWavesFolder()),win=GraphControl
	popupmenu ERROR_NEW_XN mode=1+whichlistitem(stringfromlist(1,EBdata("xwave",st),","),FindErrorWavesFolder()),win=GraphControl
	setdatafolder DF
end


//---save an error wave
Function ERROR_NEW_PopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	controlinfo/w=graphcontrol ERROR_YP
	string yerror=s_value
	controlinfo/w=graphcontrol ERROR_XP
	string xerror=s_value
	controlinfo/w=graphcontrol ERROR_SHADE
	variable doshade=v_value
	string shade="",cap="",bar=""
	string error_st=""
	if(doshade)
		xerror=""
	else
		if(stringmatch(ctrlName,"*new_xp"))
			if(popnum>1)
				xerror=popStr+","+popStr
			else	//---no waves
				xerror=""
			endif
		endif
		if(stringmatch(ctrlName,"*new_xn"))
			if(popnum>1)
				xerror=stringfromlist(0,xerror,",")+","+popStr
			else	//---no waves
				xerror=stringfromlist(0,xerror,",")+","
			endif
		endif	
	endif
	if(stringmatch(ctrlName,"*new_yp"))
		if(popnum>1)
			yerror=popStr+","+popStr
		else	//---no waves
			yerror=""
		endif
	endif
	if(stringmatch(ctrlName,"*new_yn"))
		if(popnum>1)
			yerror=stringfromlist(0,yerror,",")+","+popStr
		else	//---no waves
			yerror=stringfromlist(0,yerror,",")+","
		endif
	endif
	if(strlen(xerror)+strlen(yerror)>0)//---there are erorr waves
		if(doshade)
			controlinfo/w=graphcontrol ERROR_TRANS_SHADE
			variable alpha=v_value
			controlinfo/w=graphcontrol ERROR_SHADE_EB
			if((alpha<256)&&(itemsinlist(s_value,",")<=3))
				s_value= removeending(addlistitem(num2str(alpha*(256)),removeending(s_value),",",3))+")"
			endif
			shade=" shade = {0,0,"+s_value+",(0,0,0,0)} "
			error_st=" wave=( "+yerror+")"	
		else
			controlinfo/w=graphcontrol ERROR_CAPH
			cap="/T="+num2str(v_value)	
			controlinfo/w=graphcontrol ERROR_CAPW
			cap+="/Y="+num2str(v_value)	
			controlinfo/w=graphcontrol ERROR_BAR
			bar="/L="+num2str(v_value)
			//---gather the waves
			if(strlen(xerror)>0)
				error_st="X,wave=("+xerror+")"
			endif
			if(strlen(yerror)>0)
				error_st="Y,wave=("+yerror+")"
			endif			
			if((strlen(yerror)>0)&&(strlen(xerror)>0))
				error_st="XY,wave=("+xerror+"),wave=("+yerror+")"
			endif			
		endif
	else
		error_st="OFF"
	endif

	string DF=getdatafolder(1) 
	setdatafolder root:graphcontrol
	wave listselect
	nvar MustUpdate
	setdatafolder DF
	variable tnum
	for (tnum=0;tnum<dimsize(listselect,0);tnum+=1)
		if (listselect[tnum][0])
			string printST= "errorbars/w="+WorkingPlotName()+" "+cap+bar+" "+stringfromlist(tnum,TraceNameList(WorkingPlotName(), ";", 1 ))+shade+" "+error_st
			controlinfo/w=GraphControl PLOT_PRINT
			if(v_value)
				execute/p printST
			else
				execute/q printST
			endif	
			MustUpdate=1
		endif
	endfor	
	execute/p/q "GraphControlPanelUpdate()"

End

//---toggles shades instead of error bars
Function ERRORBARS_CHECK(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	ERROR_NEW_PopMenuProc("check",1,"")
end	

Function ERROR_TRANS_SHADE(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	ERRORBARS_CHECK("shade",1)
End

Function ERROR_SHADE_EBpopup(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	ERRORBARS_CHECK("shade",1)
End
//--updates error bars
Function ERR_VISUAL(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	ERRORBARS_CHECK(ctrlName,0)
End
//****************************************IMAGES********************************************************************
//****************************************IMAGES********************************************************************
//****************************************IMAGES********************************************************************
//---images
//---copies image params
Function IMAGECOPY(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	string/g ImageRecreation
	controlinfo /w=GraphControl PLOT_IMAGE_LIST
	variable inum=v_value
	if(inum>=0)
		string imagename=stringfromlist(inum,ImageNameList(WorkingPlotName(), ";" ))
		string info=imageinfo(WorkingPlotName(),imagename,0)
		ImageRecreation=replacestring("RECREATION:",info[strsearch(info,"RECREATION",0),strlen(info)-1],"")
	endif
	setdatafolder DF
End

//--pastes trace info saved before
Function IMAGEINFOPASTE(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	svar/z ImageRecreation
	nvar MustUpdate
	controlinfo /w=GraphControl PLOT_IMAGE_LIST
	variable inum=v_value
	if((inum>=0)&&(SVAR_Exists(ImageRecreation)))
		if(strlen(ImageRecreation)>0)
			string imagename=stringfromlist(inum,ImageNameList(WorkingPlotName(), ";" ))
			string printST= "ModifyImage/w="+WorkingPlotName()+" "+imagename+" "+removeending(replacestring(";",ImageRecreation,","))
			controlinfo/w=GraphControl PLOT_PRINT
			if(v_value)
				execute/p printST
			else
				execute/q printST
			endif	
			MustUpdate=1
			execute/p/q "GraphControlPanelUpdate()"
		endif
	endif
	setdatafolder DF
end
//---update image params
Function UpdateImageParameters([setDF])
	variable setDF
	string DF=getDataFolder(1)
	setdatafolder root:GraphControl
	svar ColorTableList
	controlinfo /w=GraphControl PLOT_IMAGE_LIST
	variable inum=v_value
	if((inum>=0)&&(strlen(WorkingPlotName())>0))
		string imagename=stringfromlist(inum,ImageNameList(WorkingPlotName(), ";" ))
		//---set the plane
		if(setDF)
			setdataFolder $stringbykey("zwavedf",imageinfo(WorkingPlotName(),imagename,0),":")
			PopupMenu PLOT_FOLDER_PARENT_LEFT value=getdatafolder(1),win=GraphControl
			UpdateDirFolder(getdatafolder(1),"LEFT")
			UpdateFolderColors()
		endif
		if(waveexists(ImageNameToWaveRef(WorkingPlotName(),imagename)))
			string colortable=stringbykey("RECREATION",imageinfo(WorkingPlotName(),imagename,0),":") 
			variable Numplane=numberbykey("plane",imageinfo(WorkingPlotName(),imagename,0),"=") 
			if(numtype(Numplane)!=0)
				Numplane= numberbykey("plane",colortable,"=") 
			endif
			Numplane=(numtype(Numplane)!=0) ? 0 : Numplane
			
			setvariable PLOT_IMAGE_PLANE,win=GraphControl,limits={0,dimsize(ImageNameToWaveRef(WorkingPlotName(),imagename),2),1},value=_num:Numplane	
			//print Numplane,colortable

			string CTname=stringfromlist(2,colortable,",")
			CTname=CTname[strsearch(CTname,":",inf,1)+1,inf]
			variable transMode=1
			if(stringmatch(colortable,"*ColorTables:TRANS2*"))
				transMode=2
			elseif(stringmatch(colortable,"*ColorTables:TRANS3*"))
				transMode=3
			elseif(stringmatch(colortable,"*ColorTables:TRANS4*"))
				transMode=4
			endif
			popupMenu PLOT_IMAGE_COLORTABLE_TRANS,mode=transMode,win=GraphControl
			ModifyImage/w=GraphControl#ColorTableDisplayImage ColorTableShowWave ctab= {0,255,$stringfromlist(2,colortable,","),str2num(stringfromlist(3,colortable,","))}
			PopupMenu PLOT_IMAGE_USE_COLOR_MIN_COLOR,disable=1,win=GraphControl
			PopupMenu PLOT_IMAGE_USE_COLOR_MAX_COLOR,disable=1,win=GraphControl
			if(stringmatch(colortable,"*ctab*"))//---color table
				colortable=removeending(replacestring("ctab= {",colortable,""))
				PopupMenu PLOT_IMAGE_COLORTABLE_NAME mode=whichlistitem( CTname,ColorTableList)+1,win=GraphControl
				PopupMenu PLOT_IMAGE_COLOR userdata=stringfromlist(2,colortable,","),win=GraphControl
				string mintype=replacestring(")",replacestring("(",stringbykey("minRGB",imageinfo(WorkingPlotName(),imagename,0),"="),""),"")
				if(strlen(mintype)>1)
					if(stringmatch(mintype,"0"))
						PopupMenu PLOT_IMAGE_USE_COLOR_MIN,mode=1,win=GraphControl	//---same as first
					elseif(stringmatch(mintype,"nan"))
						PopupMenu PLOT_IMAGE_USE_COLOR_MIN,mode=3,win=GraphControl	//---transparent
					else
						PopupMenu PLOT_IMAGE_USE_COLOR_MIN,mode=2,win=GraphControl	//---specific color
						PopupMenu PLOT_IMAGE_USE_COLOR_MIN_COLOR popColor=(str2num(stringfromlist(0,mintype,",")),str2num(stringfromlist(1,mintype,",")),str2num(stringfromlist(2,mintype,","))),win=GraphControl
						if(strlen(stringfromlist(3,mintype,","))>0)
							PopupMenu PLOT_IMAGE_USE_COLOR_MIN_COLOR popColor=(str2num(stringfromlist(0,mintype,",")),str2num(stringfromlist(1,mintype,",")),str2num(stringfromlist(2,mintype,",")),str2num(stringfromlist(3,mintype,","))),win=GraphControl
						endif
						PopupMenu PLOT_IMAGE_USE_COLOR_MIN_COLOR,disable=0,win=GraphControl
					endif
				endif
				string maxtype=replacestring(")",replacestring("(",stringbykey("maxRGB",imageinfo(WorkingPlotName(),imagename,0),"="),""),"")
				if(strlen(maxtype)>1)
					if(stringmatch(maxtype,"0"))
						PopupMenu PLOT_IMAGE_USE_COLOR_MAX,mode=1,win=GraphControl	//---same as first
					elseif(stringmatch(maxtype,"nan"))
						PopupMenu PLOT_IMAGE_USE_COLOR_MAX,mode=3,win=GraphControl	//---transparent
					else
						PopupMenu PLOT_IMAGE_USE_COLOR_MAX,mode=2,win=GraphControl	//---specific color
						PopupMenu PLOT_IMAGE_USE_COLOR_MAX_COLOR popColor=(str2num(stringfromlist(0,maxtype,",")),str2num(stringfromlist(1,maxtype,",")),str2num(stringfromlist(2,maxtype,","))),win=GraphControl
						if(strlen(stringfromlist(3,maxtype,","))>0)
							PopupMenu PLOT_IMAGE_USE_COLOR_MAX_COLOR popColor=(str2num(stringfromlist(0,maxtype,",")),str2num(stringfromlist(1,maxtype,",")),str2num(stringfromlist(2,maxtype,",")),str2num(stringfromlist(3,maxtype,","))),win=GraphControl
						endif
						PopupMenu PLOT_IMAGE_USE_COLOR_MAX_COLOR,disable=0,win=GraphControl
					endif
				endif

				CheckBox PLOT_IMAGE_COLOR_REV,value=str2num(stringfromlist(3,colortable,",")),win=GraphControl
				CheckBox PLOT_IMAGE_COLOR_LOG,value=str2num(stringbykey("LOG",imageinfo(WorkingPlotName(),imagename,0),"=")) ,win=GraphControl
				string minst=stringfromlist(0,colortable,",")
				string maxst=stringfromlist(1,colortable,",")
				CheckBox PLOT_IMAGE_COLOR_MIN_AUTO,value=(GrepString(minst,"[0-9]+")==0),win=GraphControl
				CheckBox PLOT_IMAGE_COLOR_MAX_AUTO,value=(GrepString(maxst,"[0-9]+")==0),win=GraphControl	
			endif
			variable minval=wavemin(ImageNameToWaveRef(WorkingPlotName(),imagename))
			variable maxval=wavemax(ImageNameToWaveRef(WorkingPlotName(),imagename))
			controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MIN_AUTO	//---color scale
			if(v_value)
				SetVariable PLOT_IMAGE_COLOR_MIN,value=_num:minval,win=GraphControl	
			else
				if(numtype(str2num(minst))==0)
					SetVariable PLOT_IMAGE_COLOR_MIN,value=_num:str2num(minst),win=GraphControl
				else
					SetVariable PLOT_IMAGE_COLOR_MIN,value=_num:0,win=GraphControl
				endif				
			endif
			controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MAX_AUTO
			if(v_value)
				SetVariable PLOT_IMAGE_COLOR_MAX,value=_num:maxval,win=GraphControl				
			else
				if(numtype(str2num(maxst))==0)
					SetVariable PLOT_IMAGE_COLOR_MAX,value=_num:str2num(maxst),win=GraphControl
				else
					SetVariable PLOT_IMAGE_COLOR_MAX,value=_num:0,win=GraphControl
				endif				
			endif
			controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MIN
			CheckBox PLOT_IMAGE_COLOR_MIN_AUTO,value=(v_value==minval),win=GraphControl
//			PopupMenu PLOT_IMAGE_COLOR_MINRGB disable=max((v_value==minval),V_disable),win=GraphControl
			controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MAX
			CheckBox PLOT_IMAGE_COLOR_MAX_AUTO,value=(v_value==maxval),win=GraphControl
//			PopupMenu PLOT_IMAGE_COLOR_MAXRGB disable=max((v_value==maxval),V_disable),win=GraphControl
		else	//---no images
			setvariable PLOT_IMAGE_PLANE,win=GraphControl,value=_num:0	
			SetVariable PLOT_IMAGE_COLOR_MIN,value=_num:0,win=GraphControl
			SetVariable PLOT_IMAGE_COLOR_MAX,value=_num:0,win=GraphControl
			CheckBox PLOT_IMAGE_COLOR_MIN_AUTO,value=0,win=GraphControl
			CheckBox PLOT_IMAGE_COLOR_MAX_AUTO,value=0,win=GraphControl		
			minval=0
			maxval=0
		endif
	else
		modifycontrollist ControlNameList("GraphControl", ";", "PLOT_IMAGE_*") disable=1,win=GraphControl 
		setvariable PLOT_IMAGE_PLANE,win=GraphControl,value=_num:0		
	endif
	setdatafolder $DF
end

//---image selection
Function IMAGELIST(LB_Struct) : ListBoxControl
	STRUCT WMListboxAction &LB_Struct
	string ctrlName=LB_Struct.ctrlName
	Variable row=LB_Struct.row
	Variable col=LB_Struct.col
	Variable event=LB_Struct.eventcode	
	if(event==1)//---mouse up
		string DFsave=getdatafolder(1)
		setdatafolder root:GraphControl:
		wave/t ImageListText

		if(LB_Struct.eventMod==16)//---right mouse click
			string MenuItems=""
			MenuItems+= "Remove;Edit"
			if((col==2))
				MenuItems+= "Set DF;"
			endif
			if((col==3))	//---y axis
				MenuItems=getaxistype(0)
			endif
			if((col==4))	//---x axis
				MenuItems=getaxistype(1)
			endif

			PopupContextualMenu MenuItems
			if(stringmatch(S_selection,"Remove"))
				removeimage/w=$WorkingPlotName() $ImageListText[row][0]
			endif
			if(stringmatch(S_selection,"Edit"))
				Edit/k=1  imageNameToWaveRef(WorkingPlotName(),ImageListText[row][0])
			endif
			if(stringmatch(S_selection,"Set DF"))
				execute /p/q "setdatafolder "+ImageListText[row][col]
			endif
			if((col==3)&&(strlen(S_selection)>0))	//---y axis
				IMAGECOPY("")
				string info=imageinfo(WorkingPlotName(),ImageListText[row][0],0)
				string yaxis="",xaxis=stringbykey("XAXIS",info,":")
				if(stringmatch(xaxis,"bottom*"))
					xaxis=" /b="+xaxis
				else
					xaxis=" /t="+xaxis
				endif
				if(stringmatch(S_selection,"left*"))
					yaxis=" /l="+S_selection
				else
					yaxis=" /r="+S_selection
				endif
				removeimage/w=$WorkingPlotName() $ImageListText[row][0]
				execute "appendimage/w="+WorkingPlotName()+xaxis+yaxis+" " +(stringbykey("ZWAVEDF",info,":")+stringbykey("ZWAVE",info,":"))
				IMAGEINFOPASTE("")	
			endif
			if((col==4)&&(strlen(S_selection)>0))	//---x axis
				IMAGECOPY("")
				info=imageinfo(WorkingPlotName(),ImageListText[row][0],0)
				xaxis=""
				yaxis=stringbykey("YAXIS",info,":")
				if(stringmatch(S_selection,"bottom*"))
					xaxis=" /b="+S_selection
				else
					xaxis=" /t="+S_selection
				endif
				if(stringmatch(yaxis,"left*"))
					yaxis=" /l="+yaxis
				else
					yaxis=" /r="+yaxis
				endif

				removeimage/w=$WorkingPlotName() $ImageListText[row][0]
				execute "appendimage/w="+WorkingPlotName()+xaxis+yaxis+" " +(stringbykey("ZWAVEDF",info,":")+stringbykey("ZWAVE",info,":"))
				IMAGEINFOPASTE("")
			endif			
		endif
		setdatafolder root:graphcontrol:		
		nvar MustUpdate	
		MustUpdate=1
		updatetracelist(1)
		setdatafolder $DFsave
	
		UpdateImageParameters(setDF=1)
	endif
	
end
//---color selection
Function IMAGECOLORTABLE(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string DF=getDataFolder(1)
	setdatafolder root:GraphControl
	svar ColorTableList

	controlinfo /w=GraphControl PLOT_IMAGE_LIST
	variable inum=v_value
	if (inum>-1)//---selected image
		string imagename=stringfromlist(inum,ImageNameList(WorkingPlotName(), ";" ))
		if(strlen(imagename)>0)
			string colortable=getuserdata("GraphControl","PLOT_IMAGE_COLORTABLE_NAME","")
			//if(stringmatch(ctrlName,"PLOT_IMAGE_COLORTABLE_NAME"))
				controlinfo /w=GraphControl PLOT_IMAGE_COLORTABLE_NAME
				colortable=stringfromlist(v_value-1,ColorTableList)

			//endif
			controlinfo /w=GraphControl PLOT_IMAGE_COLOR_REV
			variable rev=v_value
			controlinfo /w=GraphControl PLOT_IMAGE_COLOR_LOG
			variable collog=v_value
			controlinfo /w=GraphControl PLOT_IMAGE_COLORTABLE_TRANS
			variable trans=v_value
			
			string minst="*",maxst="*"
			string minRGB="",maxRGB=""
			variable minval=wavemin(ImageNameToWaveRef(WorkingPlotName(),imagename))
			variable maxval=wavemax(ImageNameToWaveRef(WorkingPlotName(),imagename))
			controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MIN_AUTO
			if(v_value)
				SetVariable PLOT_IMAGE_COLOR_MIN,value=_num:minval,win=GraphControl				
			else
				controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MIN
				minst=num2str(v_value)
				CheckBox PLOT_IMAGE_COLOR_MIN_AUTO,value=(v_value==minval),win=GraphControl
				//controlinfo/w=GraphControl PLOT_IMAGE_COLOR_MINRGB			//---max color
				//minRGB=",minRGB="+ s_value

			endif
			controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MAX_AUTO
			if(v_value)
				SetVariable PLOT_IMAGE_COLOR_MAX,value=_num:maxval,win=GraphControl	
			else
				controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MAX
				maxst=num2str(v_value)
				CheckBox PLOT_IMAGE_COLOR_MAX_AUTO,value=(v_value==maxval),win=GraphControl
				//controlinfo/w=GraphControl PLOT_IMAGE_COLOR_MAXRGB			//---max color
				//maxRGB=",maxRGB="+ s_value
			endif
			//controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MIN_AUTO
			//PopupMenu PLOT_IMAGE_COLOR_MINRGB disable=(v_value),win=GraphControl
			//controlinfo /w=GraphControl PLOT_IMAGE_COLOR_MAX_AUTO
			//PopupMenu PLOT_IMAGE_COLOR_MAXRGB disable=(v_value),win=GraphControl
			ModifyImage/w=GraphControl#ColorTableDisplayImage ColorTableShowWave ctab= {0,255,$"root:graphcontrol:colortables:TRANS"+num2str(trans)+":"+colortable,rev}
			string printST= "ModifyImage/w="+WorkingPlotName()+" " +imagename+" ctab= {"+minst+","+maxst+",root:graphcontrol:colortables:TRANS"+num2str(trans)+":"+colortable+","+num2str(rev)+"}"+minRGB+maxRGB+",log="+num2str(collog)	
			//---min and max
			controlinfo /w=GraphControl PLOT_IMAGE_USE_COLOR_MIN			
			if(v_value==1)			//---like first
				popupmenu PLOT_IMAGE_USE_COLOR_MIN_COLOR,disable=1,win=GraphControl
				printST+= ", minRGB=0"
			elseif(v_value==3)		//---transparent
				popupmenu PLOT_IMAGE_USE_COLOR_MIN_COLOR,disable=1,win=GraphControl
				printST+= ", minRGB=NaN"
			else					//---specific color
				popupmenu PLOT_IMAGE_USE_COLOR_MIN_COLOR,disable=0,win=GraphControl
				controlinfo/w=GraphControl PLOT_IMAGE_USE_COLOR_MIN_COLOR
				printST+= ", minRGB="+s_value
			endif
			
			controlinfo /w=GraphControl PLOT_IMAGE_USE_COLOR_MAX			
			if(v_value==1)			//---like first
				popupmenu PLOT_IMAGE_USE_COLOR_MAX_COLOR,disable=1,win=GraphControl
				printST+= ", maxRGB=0"
			elseif(v_value==3)		//---transparent
				popupmenu PLOT_IMAGE_USE_COLOR_MAX_COLOR,disable=1,win=GraphControl
				printST+= ", maxRGB=NaN"
			else					//---specific color
				popupmenu PLOT_IMAGE_USE_COLOR_MAX_COLOR,disable=0,win=GraphControl
				controlinfo/w=GraphControl PLOT_IMAGE_USE_COLOR_MAX_COLOR
				printST+= ", maxRGB="+s_value
			endif
			
			controlinfo/w=GraphControl PLOT_PRINT
			if(v_value)
				execute/p printST
			else
				execute/q printST
			endif
		endif	
	endif
	setdatafolder $DF
End

//---update of image parameters
Function IMAGEPARAMS(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	string DF=getdatafolder(1)
	variable minval,maxval
	string input="",st
	controlinfo /w=GraphControl PLOT_IMAGE_LIST
	variable inum=v_value
	if (inum>-1)//---selected image
		string imagename=stringfromlist(inum,ImageNameList(WorkingPlotName(), ";" ))
		if(strlen(imagename)>0)
			if(stringmatch(ctrlName,"PLOT_IMAGE_PLANE"))
				ModifyImage/w=$WorkingPlotName() $imagename plane=varnum	
				setvariable PLOT_IMAGE_PLANE,win=GraphControl,limits={0,dimsize(ImageNameToWaveRef(WorkingPlotName(),imagename),2),1}
				//print dimsize(ImageNameToWaveRef(WorkingPlotName(),imagename),2)
			else
				if(stringmatch(ctrlName,"PLOT_IMAGE_COLOR_*"))
					CheckBox PLOT_IMAGE_COLOR_MIN_AUTO,value=0,win=GraphControl
					CheckBox PLOT_IMAGE_COLOR_MAX_AUTO,value=0,win=GraphControl
					IMAGECOLORTABLE(ctrlName,varNum,"")
				endif
			endif
		endif
	endif
	setdatafolder DF
end

Function IMAGECHECKPARAMS(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	execute/q "IMAGECOLORTABLE(\""+ctrlName+"\",1,\"\")"
End

//---play the planes
Function IMAGEPLANEPLAY(ctrlName) : ButtonControl
	String ctrlName
	if(stringmatch(getuserData("GraphControl",ctrlName,""),"play"))
		CtrlNamedBackground ImagePlanePlay, proc=ImagePlanePlayFunc, start,period=10
		Button PLOT_IMAGE_PLANE_PLAY,userdata="stop",title="\\W5016",win=GraphControl
	else
		CtrlNamedBackground ImagePlanePlay, stop
		Button PLOT_IMAGE_PLANE_PLAY,userdata="play",title="\\W5049",win=GraphControl
	endif
End
Function ImagePlanePlayFunc(s)
	STRUCT WMBackgroundStruct &s
	controlinfo /w=GraphControl PLOT_IMAGE_LIST
	variable inum=v_value
	if (inum>-1)//---selected image
		string imagename=stringfromlist(inum,ImageNameList(WorkingPlotName(), ";" ))
		if( (strlen(imagename) >0)&&( dimsize(ImageNameToWaveRef(WorkingPlotName(),imagename),2)>1))
			variable Numplane=numberbykey("plane",imageinfo(WorkingPlotName(),imagename,0),"=")
			Numplane=(Numplane<dimsize(ImageNameToWaveRef(WorkingPlotName(),imagename),2))*(Numplane+1)
			if(Numplane>=0)
				ModifyImage/w=$WorkingPlotName() $imagename plane=Numplane	
				dowindow GraphControl	//---no window
				if(v_flag)
					setvariable PLOT_IMAGE_PLANE,win=GraphControl,value=_num:Numplane
					//print Numplane
				else
					return 1
				endif
			endif
		endif
	endif
	int err = GetRTError(0)
	if (err != 0)
		Printf "Stopping background task because of error %d\r", err
		return 1	
	endif
	
	return 0
end
//****************************************FOLDER********************************************************************
//****************************************FOLDER********************************************************************
//****************************************FOLDER********************************************************************
//---gets the wave names in current datafolder
Function/s wavesinDF(doDFdiag,ndim,npoint,wtype)
	variable doDFdiag,ndim,npoint,wtype
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:
	make/o/n=(1,2,3) DFselect=0
	make/o/t/n=(1,2) DFname=""
	DFname[0][1]="_none_"
	setdatafolder DF
	if(itemsinlist(getdatafolder(1),":")>1)
		DFname[0][0]="\\W547"	//can go up
	endif		
	variable numDF=CountObjects("", 4 )
	variable numwave=CountObjects("", 1 )
	variable wnum//,FoundWaves=0
	string waveref,DFrefST=""
	for(wnum=0;wnum<numDF;wnum+=1)//---data folder
		insertpoints/m=0 dimsize(DFname,0),1, DFname,DFselect
		DFname[dimsize(DFname,0)-1][1]=GetIndexedObjName("", 4, wnum)
		DFname[dimsize(DFname,0)-1][0]=""
		DFselect[dimsize(DFname,0)-1][0][0]=64	
		DFrefST+=GetIndexedObjName("", 4, wnum)+";"	
	endfor
	DFrefST=sortlist(DFrefST)	//---sort DF by name
	for(wnum=0;wnum<numDF;wnum+=1)//---data folder
		DFname[wnum+1][1]=stringfromlist(wnum,DFrefST)
	endfor
	string WaveRefST=""	
	for(wnum=0;wnum<numwave;wnum+=1)//---waves
		waveref=GetIndexedObjName("", 1, wnum)
		if((WaveType($waveref,1)==wtype )||(wtype==-1))
			if ((ndim==-1)||(WaveDims($waveref)==ndim))
				if((numpnts($waveref)==npoint)||(npoint==-1))
					insertpoints/m=0 dimsize(DFname,0),1, DFname,DFselect
					DFselect[dimsize(DFname,0)-1][1]=0
					DFname[dimsize(DFname,0)-1][1]= waveref
					WaveRefST+=DFname[dimsize(DFname,0)-1][1]+";"
				endif
			endif
		endif
	endfor
	WaveRefST=sortlist(WaveRefST,";",16)	//---sort waves by name
	for(wnum=0;wnum<dimsize(DFname,0)-numDF-1;wnum+=1)//---waves 
		DFname[wnum+1+numDF][1]=stringfromlist(wnum,WaveRefST)
	endfor
	for(wnum=0;wnum<dimsize(DFname,0)-numDF-1;wnum+=1)//---waves	
		DFname[wnum+1+numDF][0]= ""
		if(WaveType($DFname[wnum+1+numDF][1],1)==2)	//---text
			DFname[wnum+1+numDF][0]="T"
		elseif(dimsize($DFname[wnum+1+numDF][1],1)>0)//---matrix
			DFname[wnum+1+numDF][0]="M"
		endif
	endfor
	return DFrefST
End

//---finds the selected waves
Function FindSelectedFolderWave(testwave)
	wave testwave	
	variable DSnum	
	for(DSnum=0;DSnum<dimsize(testwave,0);DSnum++)
		if(testwave[DSnum][1]==1)
			return DSnum
		endif
	endfor
	return -1
end

//---shows the available folders
function/s ShowDataFolders(DF)
	string DF
	variable numDF=CountObjects(DF, 4 )
	variable wnum
	string waveref=""
	for(wnum=0;wnum<numDF;wnum++)
		waveref+=GetIndexedObjName(DF, 4, wnum)+";"
	endfor
	return waveref	
end

//---compute the waves in the current datafolder
function 	UpdateDirFolder(DFcheck,LeftRight)
	string DFcheck,LeftRight
	dowindow GraphControl
	if(v_flag)
		string DF=getdatafolder(1)
		setdatafolder $DFcheck
		if(stringmatch(DFcheck,"root:")==0)//---not root
			string DFrefST="\"::;"+wavesinDF(0,-1,-1,-1)+"\""
		else
			DFrefST="\""+wavesinDF(0,-1,-1,-1)+"\""
		endif
		setdatafolder root:GraphControl:
		wave/t DFname
		wave DFselect
		duplicate/o/t DFname,$LeftRight+"FolderListText"
		duplicate/o DFselect,$LeftRight+"FolderListSelect" 
		PopupMenu $"PLOT_FOLDER_PARENT_"+LeftRight,mode=1,popvalue=DFcheck,value=#DFrefST,win=GraphControl,userdata=DFcheck
		setdatafolder $DF
	endif
end

//---update the waves in datafolder window
Function PopulateDFLists()

	variable row=gettracenumber(-1)
	string DF=getdatafolder(1)
	if((row>=0)&&(row<itemsinlist(TraceNameList(WorkingPlotName(), ";", 1 ))))//---from traces
		string tracename=stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 ))	
		string info =traceinfo(WorkingPlotName(),tracename,0)
		//---y axis
		UpdateDirFolder(GetWavesDataFolder(WaveRefIndexed(WorkingPlotName(), row, 1 ),1),"left")
		//---x axis
		if (numberbykey("ISCAT",AxisInfo(WorkingPlotName(), stringbykey("XAXIS",info,":")),":"))	//---category
			UpdateDirFolder(stringbykey("HOOK",AxisInfo(WorkingPlotName(),stringbykey("XAXIS",info,":"))),"right")
		else
			if(waveexists(XWaveRefFromTrace(WorkingPlotName(),tracename)))
				UpdateDirFolder(GetWavesDataFolder(XWaveRefFromTrace(WorkingPlotName(),tracename),1),"right")
			else	//---no x wave
				UpdateDirFolder(GetWavesDataFolder(WaveRefIndexed(WorkingPlotName(), row, 1 ),1),"right")
			endif
		endif	
	else	
		UpdateDirFolder("root:","left")
		UpdateDirFolder("root:","right")
	endif
	setdatafolder $DF
end

//---shows the dir folders
function UpdateDirectories(doCurrentDF)
	variable doCurrentDF
 	dowindow GraphControl
 	if(v_flag)
 		if(doCurrentDF)
			UpdateDirFolder(getuserData("graphcontrol","PLOT_FOLDER_PARENT_LEFT",""),"LEFT")
			UpdateDirFolder(getuserData("graphcontrol","PLOT_FOLDER_PARENT_RIGHT",""),"RIGHT")	
		else
			string DF=getdataFolder(1)
			UpdateDirFolder(DF,"LEFT")
			UpdateDirFolder(DF,"RIGHT")	
		endif
	endif
end

//---colors the waves and the folders in the data folder list
Function UpdateFolderColors([clicked])
	variable clicked
	variable SelectTrace
 	dowindow GraphControl
 	if(v_flag)
		string DF=getdatafolder(1)
		setdatafolder root:graphcontrol:	
		make/o/n=2/t leftright={"left","right"}
		wave/t listtext,LeftFolderListText,RightFolderListText
		wave LeftFolderListSelect,RightFolderListSelect,listselect
		SetDimLabel 2,1,foreColors,LeftFolderListSelect
		SetDimLabel 2,1,foreColors,RightFolderListSelect
		SetDimLabel 2,2,backColors,LeftFolderListSelect
		SetDimLabel 2,2,backColors,RightFolderListSelect
		variable DSnum,tnum,folders,tracesnum=itemsinlist(TraceNameList(WorkingPlotName(), ";", 1 ))
		if(waveexists(ListText) )//(dimsize(listtext,1)>3)
			if((gettracenumber(-1)>=0)&&(clicked==0))
				SelectTrace=-1
			endif	
			for(folders=0;folders<=1;folders++)	//---left and right folder windows
				setdatafolder root:graphcontrol:	
				make/o/n=2/t leftright={"left","right"}
				duplicate/o $leftright[folders]+"FolderListSelect",FolderListSelect
				duplicate/o/t $leftright[folders]+"FolderListText",FolderListText
				make/o/n=(dimsize(FolderListSelect,0)*2+9,3) ListColor=65535								//---white
				ListColor[0]=0																						//---black
				ListColor[dimsize(ListColor,0)-9]=58000*(q<2)+42000*(q==2)									//---folder with no files
				ListColor[dimsize(ListColor,0)-8]=60000														//---gray (back)
				ListColor[dimsize(ListColor,0)-7]=26000														//---gray (front)
				ListColor[dimsize(ListColor,0)-6]=51000*(q==0)+58000*(q==1)+65535*(q==2)				//---selection background
				ListColor[dimsize(ListColor,0)-5]=30000*(q<1)+60000*(q>=1)//52000*(q<1)+60000*(q>=1)	//---text background
				ListColor[dimsize(ListColor,0)-4]=65535*(q==0)+35000*(q>0)									//---multidim background
				ListColor[dimsize(ListColor,0)-3]=50000*(q<2)+35000*(q==2)									//---folder background
				ListColor[dimsize(ListColor,0)-2]=64000														//---wave background
				ListColor[dimsize(ListColor,0)-1]=65535														//---white				
				FolderListSelect[][ ][1]=(dimsize(ListColor,0)-7)//p*(r==1)+(r==2)*(dimsize(ListColor,0)-2)
				FolderListSelect[][ ][2]=(dimsize(ListColor,0)-2)//(dimsize(FolderListSelect,0))	
				string winDF=getuserdata("GraphControl","PLOT_FOLDER_PARENT_"+leftright[folders],"")
				for (DSnum=1;DSnum<dimsize(FolderListSelect,0);DSnum++)		//---over all waves in DF
					ListColor[DSnum][0,2]=0	//---black
					if(FolderListSelect[DSnum][0][0]==64)//---folder
						string ShownDF=getuserdata("GraphControl","PLOT_FOLDER_PARENT_"+leftright[folders],"")
						if((countobjects(ShownDF+FolderListText[DSnum][1],1))+(countobjects(ShownDF+FolderListText[DSnum][1],4))>0)
							FolderListSelect[DSnum][][1,2]=(dimsize(ListColor,0)-3)*(r==2)
						else
							FolderListSelect[DSnum][][1,2]=(dimsize(ListColor,0)-9)*(r==2)
						endif
					else	//---wave
					
						FolderListSelect[DSnum][][2]=(dimsize(ListColor,0)-(1+q))	//---background gray
						for (tnum=0;tnum<dimsize(listtext,0);tnum++)		//---over all traces - colors based on the plot
							string tracename=stringfromList(tnum,TraceNameList(WorkingPlotName(), ";", 1 ))				
							if(waveexists(FolderListText)==0)
								setdatafolder DF
								return -1
							endif		
							if( (stringmatch(listtext[tnum][4+folders],winDF))&&(stringmatch(listtext[tnum][2+folders],FolderListText[DSnum][1])))//---correct directory
								string tracecolor=stringbykey("rgb(x)",traceinfo(WorkingPlotName(),tracename,0),"=")
								ListColor[DSnum][0,2]=str2num(stringfromlist(q,replacestring("(",tracecolor,""),","))
								ListColor[DSnum+dimsize(FolderListSelect,0)][0,2]=(ListColor[DSnum][q])//+(65535-ListColor[DSnum][q])/1.1)//str2num(stringfromlist(q,replacestring("(",tracecolor,""),","))
								if(folders==0)
									FolderListSelect[DSnum][][2]=(dimsize(ListColor,0)-2)	//---set back
								endif
								FolderListSelect[DSnum][1][1]=0//---set front
								FolderListSelect[DSnum][0][2]=(DSnum+(dimsize(FolderListSelect,0)))//---set background to graph color							
							endif
						endfor					
						if((FindSelectedFolderWave(LeftFolderListSelect)>=0))//&&((FindSelectedFolderWave(FolderListSelect)>=0)))
							setdatafolder $getuserdata("GraphControl","PLOT_FOLDER_PARENT_LEFT","")
							if(waveexists($LeftFolderListText[FindSelectedFolderWave(LeftFolderListSelect)][1]))
								variable dpnts=numpnts($LeftFolderListText[FindSelectedFolderWave(LeftFolderListSelect)][1])
								if(folders)	//---X waves
									setdatafolder $getuserdata("GraphControl","PLOT_FOLDER_PARENT_RIGHT","")
									if(waveexists($RightFolderListText[DSnum][1]))
										if(numpnts($RightFolderListText[DSnum][1])==dpnts)
											FolderListSelect[DSnum][1][1,]=(dimsize(ListColor,0)-8)*(r==2)
										endif
									endif
								else		//---Y waves
									if(waveexists($LeftFolderListText[DSnum][1]))
										if(numpnts($LeftFolderListText[DSnum][1])==dpnts)
											FolderListSelect[DSnum][1][1,]=(dimsize(ListColor,0)-8)*(r==2)
										endif
									endif
								
								endif
							endif
						endif					
					endif	
				endfor
				setdatafolder root:graphcontrol:	
				if(waveexists(ListColor))
					duplicate/o ListColor,$leftright[folders]+"FolderListColor"
				endif
				if(waveexists(FolderListSelect))
					duplicate/o FolderListSelect,$leftright[folders]+"FolderListSelect"
				endif
			endfor
		endif
		killwaves/z leftright,ListColor,FolderListSelect,FolderListText
		setdatafolder DF
	endif
end

//---data folder selection
Function DFselctecPopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	variable i
	string DFname=""
	if(stringmatch(ctrlName,"DFparents"))//---DF
	else	//---main graphcontrol
		if(stringmatch(popStr,"*::*"))//---go back
			DFname=getuserdata("graphcontrol",ctrlName,"")
			DFname=DFname[strsearch(DFname,":",1),inf]
			if(stringmatch(DFname,"root*")==0)
				DFname="root:"//---root folder
			endif
		else	
			DFname=getuserdata("graphcontrol",ctrlName,"")+popStr+":"
		endif
		setdatafolder DFname
		string leftright="left"
		if(stringmatch(ctrlName,"*right*"))
			leftright="right"
		endif
		doupdate/w=graphcontrol
		setdatafolder $DFname	
		SetVariable PLOT_FOLDER_CURRENTDF ,value= _STR:getdatafolder(1),win=GraphControl
			
		UpdateDirFolder(DFname,LeftRight)
		UpdateFolderColors()
	endif 
End

//---events that occur when user click the listbox
Function DFSELECTListBoxProc(LB_Struct) : ListBoxControl
	STRUCT WMListboxAction &LB_Struct
	string ctrlName=LB_Struct.ctrlName
	Variable row=LB_Struct.row
	Variable col=LB_Struct.col
	Variable event=LB_Struct.eventcode	
	string DFsave=getdatafolder(1)
	setdatafolder root:GraphControl:
	//nvar MustUpdate
	wave DFselect,DFSelectSave,RightFolderListSelect,LeftFolderListSelect,listselect
	make/o/t/n=(0,2) FoldersData	
	wave/t DFname,RightFolderListText,LeftFolderListText,ListText
	variable ndim1=-1,npoint1=-1,wtype1=-1,doDFselect=0
	variable i,DSnum
	make/o/t/n=2 leftright={"LEFT","RIGHT"}
	variable folders=-1
	if(stringmatch(ctrlName,"*left*"))
		folders=0
	elseif(stringmatch(ctrlName,"*right*"))
		folders=1
	endif		
	
	duplicate/o $leftright[folders]+"FolderListSelect",DFselect
	duplicate/o/t $leftright[folders]+"FolderListText",DFname	
	if(event==2)	//--save for multiple selection
		duplicate/o $leftright[folders]+"FolderListSelect",DFSelectSave
	endif
	string CurrentDF=getuserdata("graphcontrol","PLOT_FOLDER_PARENT_"+leftright[folders],"")
	string NewDF=getuserdata("graphcontrol","PLOT_FOLDER_PARENT_"+leftright[1-folders],"")
	if(datafolderexists(CurrentDF))
		setdatafolder $CurrentDF
	else
		CurrentDF="root:"
	endif

	if(row>=dimsize(DFselect,0))
		execute/q/p "UpdateDirFolder(\""+CurrentDF+"\",\""+leftright[folders]+"\")"
		execute /p/q "UpdateDirFolder(\""+NewDF+"\",\""+leftright[1-folders]+"\")"
		if((LB_Struct.eventmod==16)&&(event==1))
			PopupContextualMenu "New Folder;Match Folders"
			if(stringmatch(S_selection,"New Folder"))
				newdatafolder/o New
				execute/q/p "UpdateDirFolder(\""+getdatafolder(1)+"\",\""+leftright[folders]+"\")"
				execute/q/p "UpdateDirFolder(\""+NewDF+"\",\""+leftright[1-folders]+"\")"
			endif
			if(stringmatch(S_selection,"Match Folders"))
				setdatafolder $getuserdata("graphcontrol","PLOT_FOLDER_PARENT_"+leftright[1-folders],"")
				execute/q/p "UpdateDirFolder(\""+getdatafolder(1)+"\",\""+leftright[folders]+"\")"
				execute/q/p "UpdateDirFolder(\""+getdatafolder(1)+"\",\""+leftright[1-folders]+"\")"
			endif
		endif

	else
		
		if((col==1)&& (LB_Struct.eventmod==16)&&(strlen(leftright[folders])>0)&&(event==1)&&(row>0))//---menu
				//---find selected waves/folders				
			if(waveexists(DFSelectSave))
				if(dimsize(DFSelectSave,0)==(dimsize(DFname,0)))
					DFsave=CurrentDF
					for(DSnum=0;DSnum<dimsize(DFname,0);DSnum++)
						if( (DFSelectSave[DSnum][1][0]==8)||(DFSelect[DSnum][1][0]==1))
							insertpoints/m=0 0,1 ,FoldersData
							FoldersData[0][0]=num2str(DFSelect[DSnum][0])
							FoldersData[0][1]+=DFname[DSnum][1]								
							DFselect[DSnum][1][2]=dimsize(root:graphcontrol:$leftright[folders]+"FolderListColor",0)-6//+(DFselect[DSnum][1][0]==0)*7
						endif
					endfor
				endif
			endif
			if(dimsize(FoldersData,0)==0)	//---only current DF
				insertpoints/m=0 0,1, FoldersData
				FoldersData[0][0]=num2str(DFSelect[row][0])
				FoldersData[0][1]=DFname[row][1]
			else
				duplicate/o DFselect,root:graphcontrol:$leftright[folders]+"FolderListSelect"
			endif
			string MenuItems="New Folder;Match Folders;"
			if(DFselect[row][0][0]==0)//---waves
				MenuItems+="Edit;Display;"
				string xwave=""
				if((folders==0)&&(FindSelectedFolderWave(RightFolderListSelect)>-1) ) //--left, Y window
					xwave=RightFolderListText[FindSelectedFolderWave(RightFolderListSelect)][1]
					MenuItems+="Display vs "+xwave+";"
				endif
				if(strlen(WorkingPlotName())>0)
					MenuItems+="Append;"
					if(strlen(xwave)>0)
						MenuItems+="Append vs "+xwave+";"
					endif
				endif
				if(gettracenumber(-1)>=0)
					if(waveexists($ListText[gettracenumber(-1)][2])	)//---there is a wave selectd on the trace list
						if(numpnts($ListText[gettracenumber(-1)][2])==numpnts($DFname[row][1]))//---same dims
							if((folders==0)) //--left, Y window
								MenuItems+="Add Y Error Bars;"
							else
								MenuItems+="Replace X;Add X Error Bars;"
							endif
						endif
					endif
					if(folders==0) //--left, Y window
						MenuItems+="Replace Y;"
					endif
				endif				
			endif
			if(stringmatch(DFname[row][0],"M"))//---image
				MenuItems+="New Image;Add Image;"
				if((dimsize($DFname[row][1],1)==3)||(dimsize($DFname[row][1],1)==4))
					MenuItems+="Set Image z;"
				endif
				MenuItems+="Replace Image;"
			endif

			if(stringmatch(CurrentDF,NewDF)==0)//---waves and DF can be copied 
				MenuItems+="Move;"
			endif
			MenuItems+="Copy;Delete;Refresh"
			//---bring the menu
			PopupContextualMenu MenuItems
			//---refresh the panel
			if(stringmatch(S_selection,"Refresh"))
				execute /p/q "UpdateDirFolder(\""+CurrentDF+"\",\""+leftright[folders]+"\")"
				execute /p/q "UpdateDirFolder(\""+NewDF+"\",\""+leftright[1-folders]+"\")"
			endif
			if(stringmatch(S_selection,"New Folder"))
				newdatafolder/o New
				execute/q/p "UpdateDirFolder(\""+getdatafolder(1)+"\",\""+leftright[folders]+"\")"
				execute/q/p "UpdateDirFolder(\""+NewDF+"\",\""+leftright[1-folders]+"\")"
				execute/q/p "UpdateFolderColors()"
			endif
			if(stringmatch(S_selection,"Match Folders"))
				setdatafolder $getuserdata("graphcontrol","PLOT_FOLDER_PARENT_"+leftright[1-folders],"")
				execute/q/p "UpdateDirFolder(\""+getdatafolder(1)+"\",\""+leftright[folders]+"\")"
				execute/q/p "UpdateDirFolder(\""+getdatafolder(1)+"\",\""+leftright[1-folders]+"\")"
			endif
			if(stringmatch(S_selection,"Edit"))
				edit/k=1
				for(DSnum=0;DSnum<dimsize(FoldersData,0);DSnum++)
					if(waveexists($FoldersData[DSnum][1]))
						appendtotable $FoldersData[DSnum][1]
					endif
				endfor
			endif
			//---new plot or add to existing plot
			if((stringmatch(S_selection,"Display*"))||(stringmatch(S_selection,"Append*")))
				setdatafolder $getuserdata("graphcontrol","PLOT_FOLDER_PARENT_"+leftright[folders],"")
				string DisplaySt="", vsWave=""
				variable plot=stringmatch(S_selection,"Display*")			//---new plot
				for(DSnum=0;DSnum<dimsize(FoldersData,0);DSnum++)
					if(waveexists($FoldersData[DSnum][1]))
						if(stringmatch(S_selection,"*vs*")) 					//---also X wave
							if(numpnts($FoldersData[DSnum][1])==numpnts($NewDF+xwave))
								//---check that the axis is ok
								if((wavetype($NewDF+xwave,1))==2)				//---X is a text wave
									if (numberbykey("ISCAT",AxisInfo(WorkingPlotName(), "bottom"),":"))	//---category
										DisplaySt="appendtograph /w="+WorkingPlotName()+" "				//---simple append
									else
										DisplaySt="appendtograph/w="+WorkingPlotName()+"/b=BottomTxT "	//---create new axis
									endif
								else
									if (numberbykey("ISCAT",AxisInfo(WorkingPlotName(), "bottom"),":"))	//---category
										DisplaySt="appendtograph/t /w="+WorkingPlotName()+" "				//---vs. top axis
									else
										DisplaySt="appendtograph /w="+WorkingPlotName()+" "				//---simple append
									endif
								endif
								vsWave=" vs "+NewDF+xwave										
								if(plot)
									plot=0
									DisplaySt="Display/k=1 "
								endif
							endif
						else //---only Y wave
							if(plot)
								plot=0
								DisplaySt="Display/k=1 "
							else
								DisplaySt="appendtograph /w="+WorkingPlotName()+" "
								if (numberbykey("ISCAT",AxisInfo(WorkingPlotName(), "bottom"),":"))	//---category
									DisplaySt+="/t "
								endif
							endif
						endif
						if(wavetype($FoldersData[DSnum][1],1)==1)		//----Y wave has to be numeric
							execute DisplaySt+FoldersData[DSnum][1]+vsWave
						endif							
					endif						
				endfor
			endif 
			if(stringmatch(S_selection,"Replace Y"))
				variable sel
				for(sel=0;sel<dimsize(listselect,0);sel++)
					if(listselect[sel][0]>0)
						ReplaceWave /w=$WorkingPlotName() trace=$ListText[sel][2], $DFname[row][1]
					endif
				endfor
				updatetracelist(0)
			endif
			if(stringmatch(S_selection,"Replace X"))
				for(sel=0;sel<dimsize(listselect,0);sel++)
					if(listselect[sel][0]>0)
						ReplaceWave /w=$WorkingPlotName() /X trace=$ListText[sel][2], $DFname[row][1]
					endif
				endfor
				updatetracelist(0)
			endif
			//---new image (for multi-dim waves only)
			if(stringmatch(S_selection,"New Image"))
				newimage/k=1 $DFname[row][1]
				UpdateImageParameters()
			endif
			if(stringmatch(S_selection,"Add Image"))
				appendimage /w=$WorkingPlotName() $DFname[row][1]
				UpdateImageParameters()
				updatetracelist(1)
			endif
			//---set image color or replace image
			if((stringmatch(S_selection,"Set Image z"))||(stringmatch(S_selection,"Replace Image")))
				controlinfo /w=GraphControl PLOT_IMAGE_LIST
				variable inum=v_value
				if(inum>=0)	
					string imagename=stringfromlist(inum,ImageNameList(WorkingPlotName(), ";" ))
					if(stringmatch(S_selection,"Set Image z"))
						ModifyImage/w=$WorkingPlotName() $imagename ctab= {*,*,$DFname[row][1],0}
					else	//---replace wave
						ReplaceWave/w=$WorkingPlotName() image=$imagename, $DFname[row][1]
					endif
				endif
			endif		

				
			//---add error bars 
			if(stringmatch(S_selection,"Add * Error*"))
				if(stringmatch(S_selection,"Add *Y Error*"))
					ERROR_NEW_PopMenuProc("new_yp",2,DFname[row][1])
				else
					ERROR_NEW_PopMenuProc("new_xp",2,DFname[row][1])
				endif
			endif			
			//---copy/move between directories
			if((stringmatch(S_selection,"Copy"))||((stringmatch(S_selection,"Move"))))
				for(DSnum=0;DSnum<dimsize(FoldersData,0);DSnum++)
					if(str2num(FoldersData[DSnum][0])==0)	//---wave
						if(waveexists($FoldersData[DSnum][1]))
							if(stringmatch(S_selection,"Copy"))
								execute "duplicate/o "+FoldersData[DSnum][1]+","+NewDF+FoldersData[DSnum][1]//+"_copy"
							else
								execute "movewave "+FoldersData[DSnum][1]+","+NewDF+FoldersData[DSnum][1]
							endif
						endif
					else	//---folder
						if(datafolderexists(CurrentDF+FoldersData[DSnum][1]))
							if(stringmatch(S_selection,"Copy"))
								DuplicateDataFolder $CurrentDF+FoldersData[DSnum][1],$NewDF
							else
								MoveDataFolder $CurrentDF+FoldersData[DSnum][1],$NewDF
							endif
						endif
					endif
				endfor
				execute /p/q "UpdateDirFolder(\""+CurrentDF+"\",\""+leftright[folders]+"\")"
				execute /p/q "UpdateDirFolder(\""+NewDF+"\",\""+leftright[1-folders]+"\")"
			endif
			if(stringmatch(S_selection,"Delete"))
				for(DSnum=0;DSnum<dimsize(FoldersData,0);DSnum++)
					if(str2num(FoldersData[DSnum][0])==0)	//---wave
						if(waveexists($FoldersData[DSnum][1]))
							killwaves/z $FoldersData[DSnum][1]
						endif
					else	//---folder
						if(datafolderexists(CurrentDF+FoldersData[DSnum][1]))
							killdatafolder/z $CurrentDF+FoldersData[DSnum][1]
						endif
					endif
				endfor			
				execute /p/q "UpdateDirFolder(\""+CurrentDF+"\",\""+leftright[folders]+"\")"
				execute /p/q "UpdateDirFolder(\""+NewDF+"\",\""+leftright[1-folders]+"\")"
			endif	
			execute/q/p "UpdateFolderColors()"	
			int err = GetRTError(0)
			if (err != 0)
				Printf "Stopping background task because of error %d\r", err
				return 1	
			endif
					
			return 0			
		endif	//---end right click menu
		if((col==0)&&(row==0)&&(event==4))//---go up one level
			DFselect[][][0]=0
			if(itemsinlist(getdatafolder(1),":")>1)
				setdatafolder ::
				DFsave=getdatafolder(1)
			endif
			wavesinDF(doDFselect,ndim1,npoint1,wtype1)
			execute/q/p "UpdateDirFolder(\""+getdatafolder(1)+"\",\""+leftright[folders]+"\")"
		endif
		if((col==0)&&(row>0))
			DFselect[][1][0]=(p==row)
		endif
		if((row>0))
			if((event==2)&&(DFselect[row][0]>=64)&&(col==0))//---get into the folder
				setdatafolder DFname[row][1]
				DFsave=getdatafolder(1)
		//		SetVariable PLOT_FOLDER_CURRENTDF ,value= _STR:getdatafolder(1),win=GraphControl
				if(col==0)
					DFselect[row][1][0]=0
					wavesinDF(doDFselect,ndim1,npoint1,wtype1)
					execute/q/p "UpdateDirFolder(\""+getdatafolder(1)+"\",\""+leftright[folders]+"\")"
				endif
			endif
			if((col==1)&&(event==4)&&(DFselect[row][0]==0))//---select a wave
				DFselect[row][][0]=0
			endif
			if(event==2)
				DFsave=CurrentDF
			endif
			if ((event==3))//---double click -rename
				DFselect[row][1][0]=6
				duplicate/o DFselect,root:graphcontrol:$leftright[folders]+"FolderListSelect"
				string DF=getdatafolder(1)
				setdatafolder root:GraphControl:
				string/g DCwave=DFname[row][1]
				setdatafolder $DF
			endif
			if (event==7)//---finish edit double click -rename
				DF=getdatafolder(1)
				setdatafolder root:GraphControl:
				svar DCwave
				setdatafolder $DF
				if(DFselect[row][0][0]==0)//---waves
					if(strlen(DCwave)*strlen(DFname[row][1])>0)//---non zero long wave name
						if(waveexists($DCwave))
							rename $DCwave, $DFname[row][1]
						endif
					endif	
				else //---folder		
					RenameDataFolder $DCwave, $DFname[row][1]
					doupdate/w=graphcontrol
		//			SetVariable PLOT_FOLDER_CURRENTDF ,value= _STR:getdatafolder(1),win=GraphControl
				endif
				DFselect[row][1][0]=1
				execute/q/p "UpdateDirFolder(\""+getdatafolder(1)+"\",\""+leftright[folders]+"\")"
				execute /p/q "UpdateDirFolder(\""+NewDF+"\",\""+leftright[1-folders]+"\")"
			endif
		endif	
	endif
	setdatafolder $DFsave
	SetVariable PLOT_FOLDER_CURRENTDF ,value= _STR:getdatafolder(1),win=GraphControl
	execute/q/p "UpdateFolderColors()"
	int error = GetRTError(0)
	if (error != 0)
		Printf "Stopping background task because of error %d\r", err
		return 1	
	endif
	
	return 0
End


//****************************************TRACES*******************************************************************
//****************************************TRACES********************************************************************
//****************************************TRACES********************************************************************
//---pastes traces saved before
Function TRACE_PASTE(ctrlName) : ButtonControl
	String ctrlName
	pastetrace("","")
End
//---changes the trace controls on graphcontrol panel accordingly to selected trace
function updatetracecontrols()
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	svar ColorTableList
	wave/t ImageListText
//	wave Color3d,Color3dCol
	//wave plotADVANCEDx,plotADVANCEDxSAVE
	string/g enablelist="",disablelist=""
	string info="",tracename
	variable found,tnum,i,moveTableColorWindow=1
	setdatafolder DF
	dowindow GraphControl
	if(v_flag)
		//execute/q/p "UpdateFolderColors(clicked=0)"
		if(gettracenumber(-1)==-1)
			disablelist=ControlNameList("GraphControl", ";", "TRACEMAIN*")+ControlNameList("GraphControl", ";", "ERROR*")//+"PLOT_LINK;"
			disablelist+=ControlNameList("GraphControl", ";", "*fill*")
			disablelist+=ControlNameList("GraphControl", ";", "*MARKER*")
			disablelist+=ControlNameList("GraphControl", ";", "*advance*")
			//plotADVANCEDx=-1
		endif
		
		if(gettracenumber(-1)>-1) //trace selected
			//plotADVANCEDx=plotADVANCEDxSAVE
			enablelist=ControlNameList("GraphControl", ";", "TRACE*")
			controlinfo/w=GraphControl GC_ERRORS//---errors
			if(stringmatch(S_UserData,"inactive"))	
				enablelist+=ControlNameList("GraphControl", ";", "ERROR*")//ControlNameList("GraphControl", ";", "*")//+ControlNameList("GraphControl", ";", "ERROR*")		 
				controlinfo/w=graphcontrol ERROR_SHADE
				PopupMenu ERROR_SHADE_EB,win=GraphControl,disable=v_value==0
				SetVariable ERROR_TRANS_SHADE,win=GraphControl,disable=v_value==0
				SetVariable ERROR_CAPW,win=GraphControl,disable=v_value
				SetVariable ERROR_CAPH,win=GraphControl,disable=v_value
				SetVariable ERROR_BAR,win=GraphControl,disable=v_value
			else
				disablelist+=ControlNameList("GraphControl", ";", "ERROR*")//+"PLOT_LINK;"			
			endif
			//---end errors		
			tracename=stringfromlist(gettracenumber(-1),TraceNameList(WorkingPlotName(), ";", 1 ))
			info =traceinfo(WorkingPlotName(),tracename,0)	
			popupmenu TRACEMAIN_MODE mode=numberbykey("mode(x)",info,"=")+1,win=GraphControl
			popupmenu TRACE_ADVANCE_TOMODE mode=numberbykey("tomode(x)",info,"=")+1,win=GraphControl
			popupmenu TRACE_FILLTYPEplus mode=numberbykey("hbFill(x)",info,"=")+1,win=GraphControl
			popupmenu TRACE_FILLTYPEneg mode=numberbykey("hBarNegFill(x)",info,"=")+2,win=GraphControl
			popupmenu TRACEMAIN_LINE mode=numberbykey("lstyle(x)",info,"=")+1,win=GraphControl
			popupmenu TRACE_MARKER mode=numberbykey("marker(x)",info,"=")+1,win=GraphControl
			execute "popupmenu TRACEMAIN_COLFILLplus popcolor="+stringbykey("plusRGB(x)",info,"=")+",win=GraphControl"
			execute "popupmenu TRACEMAIN_COLFILLneg popcolor="+stringbykey("negRGB(x)",info,"=")+",win=GraphControl"
			SetVariable TRACEMAIN_LINESIZE value=_NUM:numberbykey("lsize(x)",info,"="),win=GraphControl
			SetVariable TRACE_MARKERSIZE value=_NUM:numberbykey("msize(x)",info,"="),win=GraphControl
			SetVariable TRACE_MARKERSKIP value=_NUM:numberbykey("mskip(x)",info,"="),win=GraphControl
			SetVariable TRACE_MARKERTHICK value=_NUM:numberbykey("mrkThick(x)",info,"="),win=GraphControl
			string offset=replacestring("{",stringbykey("offset(x)",info,"="),"")
			SetVariable TRACE_OFFSET_X value=_NUM:str2num(stringfromlist(0,offset,",")),win=GraphControl
			SetVariable TRACE_OFFSET_Y value=_NUM:str2num(stringfromlist(1,offset,",")),win=GraphControl
			offset=replacestring("{",stringbykey("muloffset(x)",info,"="),"")
			SetVariable TRACE_OFFSET_MULX value=_NUM:str2num(stringfromlist(0,offset,",")),win=GraphControl
			SetVariable TRACE_OFFSET_MULY value=_NUM:str2num(stringfromlist(1,offset,",")),win=GraphControl
			//---line color
			variable alpha=256
			string colRGB=stringbykey("rgb(x)",info,"=")
			if( itemsinlist(stringbykey("rgb(x)",info,"="),",")==4)
				colRGB=removeending (removelistitem(3,colRGB,","))+")"
				alpha=str2num(stringfromlist(3,stringbykey("rgb(x)",info,"="),","))/((256))				
			endif			
			execute "popupmenu TRACEMAIN_COL popcolor="+colRGB+",win=GraphControl"
			SetVariable TRACEMAIN_COLTRANS value=_NUM:alpha,win=GraphControl
			//---stroke color
			alpha=256
			colRGB=stringbykey("mrkStrokeRGB(x)",info,"=")
			if( itemsinlist(stringbykey("mrkStrokeRGB(x)",info,"="),",")==4)
				colRGB=removeending (removelistitem(3,colRGB,","))+")"
				alpha=str2num(stringfromlist(3,stringbykey("mrkStrokeRGB(x)",info,"="),","))/(256)			
			endif			
			execute "popupmenu TRACE_MARKERCOLSTROKE popcolor="+colRGB+",win=GraphControl"
			SetVariable TRACE_MARKERCOLSTROKETRANS value=_NUM:alpha,win=GraphControl
			CheckBox TRACE_MARKERSTROKE value=numberbykey("useMrkStrokeRGB(x)",info,"="),win=GraphControl
			CheckBox TRACE_MARKEROPAQUE value=numberbykey("opaque(x)",info,"="),win=GraphControl
			CheckBox TRACE_FILLCOLORplus value=numberbykey("usePlusRGB(x)",info,"="),win=GraphControl
			CheckBox TRACE_FILLCOLORneg value=numberbykey("usenegRGB(x)",info,"="),win=GraphControl
			//---z waves
			string recreation=replacestring("RECREATION:",info[strsearch(info,"RECREATION",0),strlen(info)-1],"")
			controlinfo/w=GraphControl TRACE_ADVANCE_SELECT
			variable zmode=v_value
			string minst="0",maxst="1",command=""
			found=0
			//---find active zwaves
			
			string zcolors=removeending(replacestring("{",stringbykey("zColor(x)",recreation,"="),""))
			checkBox TRACE_ADVANCE_CHECK_COLOR,value=strlen(zcolors)>0,win=GraphControl
			string zsize=removeending(replacestring("{",stringbykey("zmrkSize(x)",recreation,"="),""))
			checkBox TRACE_ADVANCE_CHECK_SIZE,value=strlen(zsize)>0,win=GraphControl
			string znumber=removeending(replacestring("{",stringbykey("zmrkNum(x)",recreation,"="),""))
			checkBox TRACE_ADVANCE_CHECK_NUMBER,value=strlen(znumber)>0,win=GraphControl
			if(zmode==1)//---color
				disablelist=addlistitem("TRACE_ADVANCE_MARK_MAX" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_MARK_MIN" ,disablelist)
				command=zcolors
			endif
			if(zmode==2)//---marker size
				disablelist=addlistitem("TRACE_ADVANCE_COLOR" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_NAME" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLOR_REV" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_TRANS" ,disablelist)
//				disablelist=addlistitem("TRACE_ADVANCE_TABLE" ,disablelist)
				command=zsize
			endif
			if(zmode==3)//---number
				command=znumber
				PopupMenu TRACE_ADVANCE_ZWAVE,popvalue=command,mode=1,win=GraphControl
//				disablelist=addlistitem("TRACE_ADVANCE_TABLE" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_NAME" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_TRANS" ,disablelist)
			endif		
			if((strlen(command)>1)&&(zmode<3))	//---there are z-color waves
				found=1
				string zwave=stringfromlist(0,command,",")
				PopupMenu TRACE_ADVANCE_ZWAVE,popvalue=zwave,mode=1,win=GraphControl
				if(zmode==1)//---color
					string ZColorTable=stringfromlist(3,command,",")
					variable colorTable=(stringmatch(ZColorTable,"ctableRGB"))+1
					controlinfo/w= GraphControl TRACE_ADVANCE_COLORTABLE_NAME
					variable topPos=v_top,rightPos=v_right
					controlinfo/w= GraphControl TRACE_ADVANCE_COLOR_REV
					variable rev=v_value
					disablelist=addlistitem("TRACE_ADVANCE_COLOR" ,disablelist)
					setwindow graphcontrol#colortabledisplay hide=0

					if(colorTable!=1)
						string CTname=stringfromlist(5,command,","),TransDF
						TransDF=CTname[strsearch(CTname,":",strsearch(CTname,":",inf,1)-1,1)+1,strsearch(CTname,":",inf,1)-1]
						CTname=CTname[strsearch(CTname,":",inf,1)+1,inf]
						if(stringmatch(TransDF,"*TRANS*"))	//---part of the regular colortables						
							if(stringmatch(TransDF,"ColorTables")==0)
								TransDF="ColorTables:"+TransDF
							endif
							TransDF="root:GraphControl:"+(TransDF)+":"+(CTname )
						else
							TransDF=stringfromlist(5,command,",")
						endif
						ModifyImage/w=GraphControl#ColorTableDisplay ColorTableShowWave ctab= {0,255,$TransDF,rev}
						wave ColorTableMain=$TransDF
						popupMenu TRACE_ADVANCE_COLORTABLE_NAME,mode=whichlistitem(CTname,ColorTableList)+1,win=GraphControl
						variable transMode=1
						if(stringmatch(TransDF,"*ColorTables:TRANS2*"))
							transMode=2
						elseif(stringmatch(TransDF,"*ColorTables:TRANS3*"))
							transMode=3
						elseif(stringmatch(TransDF,"*ColorTables:TRANS4*"))
							transMode=4
						endif
						popupMenu TRACE_ADVANCE_COLORTABLE_TRANS,mode=transMode,win=GraphControl

					elseif(colorTable!=2)
//						disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_NAME" ,disablelist)
					endif
					rightPos=200
					ModifyGraph /w=GraphControl#ColorTableDisplay margin=-1,width=250-rightPos,height=17,nticks=0,axThick=0
					movesubwindow/w=GraphControl#ColorTableDisplay fnum=(rightPos+10,topPos+0,1000,topPos+1)

					PopupMenu TRACE_ADVANCE_COLOR mode=whichlistitem( stringfromlist(3,command,","),CTabList())+1,win=GraphControl
					//print stringfromlist(4,command,","),command
					CheckBox TRACE_ADVANCE_COLOR_REV,value=str2num(stringfromlist(4,command,",")),win=GraphControl
				endif
				if(zmode<3)//---color/size
					minst=stringfromlist(1,command,",")
					maxst=stringfromlist(2,command,",")
					CheckBox TRACE_ADVANCE_COLOR_MIN_AUTO,value=(GrepString(minst,"[0-9]+")==0),win=GraphControl
					CheckBox TRACE_ADVANCE_COLOR_MAX_AUTO,value=(GrepString(maxst,"[0-9]+")==0),win=GraphControl
					//---min color
					string mintype=replacestring(")",replacestring("(",stringbykey("zcolormin(x)",recreation,"="),""),"")
					if(stringmatch(mintype,"0"))
						PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MIN,mode=1,win=GraphControl	//---same as first
						disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_COLOR_MIN" ,disablelist)
					elseif(stringmatch(mintype,"nan"))
						PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MIN,mode=3,win=GraphControl	//---transparent
						disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_COLOR_MIN" ,disablelist)
					else
						PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MIN,mode=2,win=GraphControl	//---specific color
						PopupMenu TRACE_ADVANCE_COLORTABLE_COLOR_MIN popColor=(str2num(stringfromlist(0,mintype,",")),str2num(stringfromlist(1,mintype,",")),str2num(stringfromlist(2,mintype,","))),win=GraphControl
						if(strlen(stringfromlist(3,mintype,","))>0)
							PopupMenu TRACE_ADVANCE_COLORTABLE_COLOR_MIN popColor=(str2num(stringfromlist(0,mintype,",")),str2num(stringfromlist(1,mintype,",")),str2num(stringfromlist(2,mintype,",")),str2num(stringfromlist(3,mintype,","))),win=GraphControl
						endif
					endif
					//---max color
					string maxtype=replacestring(")",replacestring("(",stringbykey("zcolormax(x)",recreation,"="),""),"")
					if(stringmatch(maxtype,"0"))
						PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MAX,mode=1,win=GraphControl	//---same as first
						disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_COLOR_MAX" ,disablelist)
					elseif(stringmatch(maxtype,"nan"))
						PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MAX,mode=3,win=GraphControl	//---transparent
						disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_COLOR_MAX" ,disablelist)
					else
						PopupMenu TRACE_ADVANCE_COLORTABLE_USE_COLOR_MAX,mode=2,win=GraphControl	//---specific color
						PopupMenu TRACE_ADVANCE_COLORTABLE_COLOR_MAX popColor=(str2num(stringfromlist(0,maxtype,",")),str2num(stringfromlist(1,maxtype,",")),str2num(stringfromlist(2,maxtype,","))),win=GraphControl
						if(strlen(stringfromlist(3,maxtype,","))>0)
							PopupMenu TRACE_ADVANCE_COLORTABLE_COLOR_MAX popColor=(str2num(stringfromlist(0,maxtype,",")),str2num(stringfromlist(1,maxtype,",")),str2num(stringfromlist(2,maxtype,",")),str2num(stringfromlist(3,maxtype,","))),win=GraphControl
						endif
					endif

				endif
			else
				if(zmode<3)
					PopupMenu TRACE_ADVANCE_ZWAVE,popvalue="_none_",mode=1,win=GraphControl
				endif
			endif
				
			if(found)
				if(waveexists($zwave))				
					variable minval=wavemin($zwave)
					variable maxval=wavemax($zwave)
				else
					minval=0
					maxval=1
				endif
				controlinfo /w=GraphControl TRACE_ADVANCE_COLOR_MIN_AUTO	//---color scale
				if(v_value)
					SetVariable TRACE_ADVANCE_COLOR_MIN,value=_num:minval,win=GraphControl	
				else
					if(numtype(str2num(minst))>0)
						minst="0"
					endif
					SetVariable TRACE_ADVANCE_COLOR_MIN,value=_num:str2num(minst),win=GraphControl				
				endif
				controlinfo /w=GraphControl TRACE_ADVANCE_COLOR_MAX_AUTO	//---color scale
				if(v_value)
					SetVariable TRACE_ADVANCE_COLOR_MAX,value=_num:maxval,win=GraphControl	
				else
					if(numtype(str2num(maxst))>0)
						maxst="1"
					endif
					SetVariable TRACE_ADVANCE_COLOR_MAX,value=_num:str2num(maxst),win=GraphControl				
				endif
				controlinfo /w=GraphControl TRACE_ADVANCE_COLOR_MIN
				CheckBox TRACE_ADVANCE_COLOR_MIN_AUTO,value=(v_value==minval),win=GraphControl
				controlinfo /w=GraphControl TRACE_ADVANCE_COLOR_MAX
				CheckBox TRACE_ADVANCE_COLOR_MAX_AUTO,value=(v_value==maxval),win=GraphControl
				//---marker size
				if(numtype(str2num(stringfromlist(3,command,",")))==0)
					SetVariable TRACE_ADVANCE_MARK_MIN,value=_num:str2num(stringfromlist(3,command,",")),win=GraphControl	
				else
					SetVariable TRACE_ADVANCE_MARK_MIN,value=_num:1,win=GraphControl	
				endif
				if(numtype(str2num(stringfromlist(4,command,",")))==0)
					SetVariable TRACE_ADVANCE_MARK_MAX,value=_num:str2num(stringfromlist(4,command,",")),win=GraphControl	
				else
					SetVariable TRACE_ADVANCE_MARK_MAX,value=_num:10,win=GraphControl	
				endif				

			else
				disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_TRANS" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLORTABLE_NAME" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLOR" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLOR_REV" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLOR_MIN_AUTO" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLOR_MIN" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLOR_MAX_AUTO" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_COLOR_MAX" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_MARK_MAX" ,disablelist)
				disablelist=addlistitem("TRACE_ADVANCE_MARK_MIN" ,disablelist)
			endif
			//---error bars
			readEB(info,stringfromlist(gettracenumber(-1),TraceNameList(WorkingPlotName(), ";", 1 )),1)
			controlinfo/w=GraphControl TRACEMAIN_MODE 
			if((V_value!=6)&&(V_value!=8))
				disablelist+=ControlNameList("GraphControl", ";", "*fill*")
			endif
			if((V_value<4)||((V_value>5)&&(v_value<9)))
				disablelist+=ControlNameList("GraphControl", ";", "*MARKER*") 
			endif
			variable axisleft=max(whichlistitem(stringbykey("YAXIS",info,":"),getaxistype(0)),whichlistitem(stringbykey("YAXIS",info,":"),getaxistype(1)))
			variable axisbottom=max(whichlistitem(stringbykey("XAXIS",info,":"),getaxistype(0)),whichlistitem(stringbykey("XAXIS",info,":"),getaxistype(1)))
			popupmenu PLOT_AXIS_LEFT mode=axisleft+1,win=GraphControl
			popupmenu PLOT_AXIS_BOTTOM mode=axisbottom+1,win=GraphControl
			//updateplotparams()
		else	//---no trace selected
			//---check the images
			controlinfo/w=graphcontrol PLOT_IMAGE_LIST
			if((v_value>=-1)&&(v_value<dimsize(ImageListText,0)))
				info=imageinfo(WorkingPlotName(),ImageListText[v_value][0],0)
				//axisleft=stringbykey("YAXIS",info,":")
				axisleft=whichlistitem(stringbykey("YAXIS",info,":"),getaxistype(0))
				axisbottom=whichlistitem(stringbykey("XAXIS",info,":"),getaxistype(1))
				popupmenu PLOT_AXIS_LEFT mode=axisleft+1,win=GraphControl
				popupmenu PLOT_AXIS_BOTTOM mode=axisbottom+1,win=GraphControl
			else
			//print v_value
				controlinfo/w=graphcontrol PLOT_AXIS_LEFT
				if(v_value>0)//there are axes
					if(stringmatch(s_value,stringfromlist(0,getaxistype(0)))==0)
						popupmenu PLOT_AXIS_LEFT mode=1,win= graphcontrol 	
					endif
					controlinfo/w=graphcontrol PLOT_AXIS_BOTTOM
					if(stringmatch(s_value,stringfromlist(0,getaxistype(1)))==0)
						popupmenu PLOT_AXIS_BOTTOM mode=1,win= graphcontrol 
					endif
					popupmenu PLOT_AXIS_LEFT mode=1, win=GraphControl
					popupmenu PLOT_AXIS_BOTTOM mode=1, win=GraphControl
				endif
			endif
		endif
		controlinfo/w=GraphControl GC_TRACES
		if(stringmatch(S_UserData,"active"))	
			disablelist+=ControlNameList("GraphControl", ";", "tracemain*")
		endif
		controlinfo/w=GraphControl GC_MARKERS
		if(stringmatch(S_UserData,"active"))	
			disablelist+=ControlNameList("GraphControl", ";", "*advance*")
			disablelist+=ControlNameList("GraphControl", ";", "*fill*")
			disablelist+=ControlNameList("GraphControl", ";", "*MARKER*")
		endif
		controlinfo/w=GraphControl GC_OFFSET
		if(stringmatch(S_UserData,"active"))	
			disablelist+=ControlNameList("GraphControl", ";", "*OFFSET*")
		endif
		disablelist=removefromlist("GC_MARKERS",disablelist)
		disablelist=removefromlist("GC_OFFSET",disablelist)
		for(i=0;i<itemsinlist(enablelist);i+=1)	//enbale controls 
			modifycontrollist stringfromlist(i,enablelist) disable=0,win=GraphControl 
		endfor
		for(i=0;i<itemsinlist(disablelist);i+=1)	//disable controls not in use
			modifycontrollist stringfromlist(i,disablelist) disable=1,win=GraphControl 
			if(stringmatch(stringfromlist(i,disablelist),"TRACE_ADVANCE_COLORTABLE_NAME") )
				setwindow graphcontrol#colortabledisplay hide=1
			//movesubwindow/w=GraphControl#ColorTableDisplay fnum=(400,0,120,10)
				//ModifyGraph /w=GraphControl#ColorTableDisplay width=2//,frame=1
			endif

		endfor
	endif
	setdatafolder DF
	
end


//---updates the trace information according to selection 
function updatetracelist(event)
	variable event
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:
	variable stop=0
	svar PlotName
	wave listselect
	wave/t listtext,ImageListText
	dowindow GraphControl	
	if(V_flag) //graph control exists
		if((event==2)||(event==15))//kill or hide target window
			stop=1						
		endif
		if ((strlen(WorkingPlotName()))&&(stop==0))//target windows exists
			DoWindow/T GraphControl,"Graph Contol - "+WorkingPlotName()
			SetWindow $PlotName hook(newgraphcontrol)=GraphControlHook
			
			variable tracesnum=itemsinlist(TraceNameList(WorkingPlotName(), ";", 1 ))
			variable imagesnum=itemsinlist(ImageNameList(WorkingPlotName(), ";" ))
			if((event==0)||(event==16))//activate or unhide
				make/o/WAVE/n=(tracesnum) ywaveref,xwaveref
			endif
			Redimension/N=(tracesnum,9) listselect
			Redimension/N=(tracesnum) ywaveref,xwaveref
			if(numpnts(listselect)>0)
			//	listselect=mod(listselect,2)
			endif
			//updateplotparams()
			//---fill the information
			Redimension /n=(tracesnum,9) listtext
			Redimension/n=(imagesnum,5) ImageListText
			variable tnum,inum
			string st 
			for (inum=0;inum<imagesnum;inum+=1)
				string imagename=stringfromlist(inum,ImageNameList(WorkingPlotName(), ";" ))	
				string info =imageinfo(WorkingPlotName(),imagename,0)
				ImageListText[inum][0]=imagename
				ImageListText[inum][1]=num2str(dimsize(ImageNameToWaveRef(WorkingPlotName(),imagename),0))+"x"+num2str(dimsize(ImageNameToWaveRef(WorkingPlotName(),imagename),1))+"x"+num2str(dimsize(ImageNameToWaveRef(WorkingPlotName(),imagename),2))
				ImageListText[inum][2]=stringbykey("ZWAVEDF",info,":")
				ImageListText[inum][3]=stringbykey("YAXIS",info,":")
				ImageListText[inum][4]=stringbykey("XAXIS",info,":")
			endfor
			
			for (tnum=0;tnum<tracesnum;tnum+=1)
				string tracename=stringfromlist(tnum,TraceNameList(WorkingPlotName(), ";", 1 ))	
				info =traceinfo(WorkingPlotName(),tracename,0)
				ywaveref[tnum]=waverefindexed(WorkingPlotName(),tnum,1)
				xwaveref[tnum]=XWaveRefFromTrace(WorkingPlotName(), tracename )
				string tracecolor=stringbykey("rgb(x)",info,"=")
				//---position
				listtext[tnum][0]=num2str(tnum+1)
				if((tnum==0)&&(tnum<tracesnum-1))
					listtext[tnum][0]+="\W523"//+"\W522"506
				endif					
				if((tnum>0)&&	(tnum<tracesnum-1))
					listtext[tnum][0]+="\W523"//529"//+"\W522"506
				endif
				if(tnum==tracesnum-1)
					listtext[tnum][0]+="\W517"
				endif
				//---color
				listtext[tnum][1]="\\JC\\k"+tracecolor+"\\W509"//\W516"" C• "//
				listselect[tnum][1]=0	
				//---y wave
				listtext[tnum][2]=tracename
				listselect[tnum][2]=6	
				//---x wave
				listtext[tnum][3]=stringbykey("XWAVE",info,":")
				listselect[tnum][3]=6
				//---no x wave or category
				if (numberbykey("ISCAT",AxisInfo(WorkingPlotName(), stringbykey("XAXIS",info,":")),":"))	//---category
					listtext[tnum][3]=stringbykey("CATWAVE",AxisInfo(WorkingPlotName(), stringbykey("XAXIS",info,":")),":")
					listtext[tnum][5]=stringbykey("HOOK",AxisInfo(WorkingPlotName(), stringbykey("XAXIS",info,":")),":")
				else
					if(strlen(stringbykey("XWAVE",info,":"))==0)
						listtext[tnum][3]=""
						listselect[tnum][3]=0
					else
						if(waveexists(XWaveRefFromTrace(WorkingPlotName(),tracename)))
							listtext[tnum][5]=GetWavesDataFolder(XWaveRefFromTrace(WorkingPlotName(),tracename),1)
						else
							listtext[tnum][5]=""
						endif
					endif			
				endif
				//---y df
				listtext[tnum][4]=GetWavesDataFolder(WaveRefIndexed(WorkingPlotName(), tnum, 1 ),1)
				//---x df
				//---y axis
				listtext[tnum][6]=stringbykey("YAXIS",info,":")
				listselect[tnum][6]=6		
				//---/x axis
				listtext[tnum][7]=stringbykey("XAXIS",info,":")
				listselect[tnum][7]=6	
				listtext[tnum][8]=num2str(dimsize(ywaveref[tnum],0))+"x"+num2str(dimsize(ywaveref[tnum],1))+"x"+num2str(dimsize(ywaveref[tnum],2))
			endfor
		else //---no top plot
			make/o/n=(0,9) listselect=0
			make/o/t/n=(0,9) listtext
			make/o/t/n=(9) listtitle
		endif
	endif
	setdatafolder DF	
end
//---helper function - fix to dots and '
function/s fixDOTwaves(wavestr)
	string wavestr
	string dfstr,wavest,check_
	variable findwavestart
	if((stringmatch(wavestr,"*.*"))||(stringmatch(wavestr,"*_*")))
		findwavestart=strsearch(wavestr,":",strlen(wavestr)-1,1)		
		dfstr=wavestr[0,findwavestart]
		wavest=wavestr[findwavestart+1,strlen(wavestr)-1]
		check_=wavestr[findwavestart+1]
		if((stringmatch(check_,"_"))||(stringmatch(wavestr,"*.*")))
			return dfstr+"'"+wavest+"'"
		endif
	endif
	return wavestr
end
//---helper function-finds the user selected trace
function gettracenumber(number)
	variable number	//if -1 searches for the first selected row
	variable tnum
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	wave listselect
	if(number==-1)
		for (tnum=0;tnum<dimsize(listselect,0);tnum+=1)
			if ((listselect[tnum][0]))
				setdatafolder DF	
				return tnum		//---selected row
			endif	
		endfor	
	endif
	setdatafolder DF	
	return -1						//---row number or -1 if none was selected
end

//---executes edit of selected wave
function editwaves(listselect,row)
	wave listselect
	variable row
	string wavey=GetWavesDataFolder(WaveRefIndexed(WorkingPlotName(), row, 1 ),2)
	string tracename=stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 ))
	if(waveexists(XWaveRefFromTrace(WorkingPlotName(),tracename)))
		string wavex=GetWavesDataFolder(XWaveRefFromTrace(WorkingPlotName(),tracename),2)
		edit/k=1 $wavey,$wavex
	else
		edit/k=1 $wavey
	endif
	//---error waves
	string info=traceinfo(WorkingPlotName(),tracename,0)
	string ERR=stringbykey("ERRORBARS",info,":")
	if(strlen(ERR)>0)		
		variable del=strsearch(ERR,"(",strlen(ERR),1)
		ERR=replacestring(ERR[0,del],ERR,"")
		ERR=removeending(ERR)
		del=strsearch(ERR,",",0)
		string PERR=ERR[0,del-1],NERR=ERR[del+1,strlen(ERR)-1]
		if(strlen(PERR)>0)
			appendtotable $PERR
		endif
		if(strlen(NERR)>0)
			appendtotable $NERR
		endif		
	endif
	//---z waves
	string recreation=replacestring("RECREATION:",info[strsearch(info,"RECREATION",0),strlen(info)-1],"")
	string zwave=stringfromlist(0,removeending(replacestring("{",stringbykey("zColor(x)",recreation,"="),"")),",")
	if(waveexists($zwave))
		appendtotable $zwave
	endif
	zwave=stringfromlist(0,removeending(replacestring("{",stringbykey("zmrkSize(x)",recreation,"="),"")),",")
	if(waveexists($zwave))
		appendtotable $zwave
	endif
	zwave=stringbykey("zmrkNum(x)",recreation,"=")
	if(waveexists($zwave))
		appendtotable $zwave
	endif		
end

//*************************************************************CONTROLS*********************************************//
Function TRACE_PARAMS(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	changetraceparams(ctrlName,popNum,popStr)
	updatetracelist(0)
	updatetracecontrols()
End
Function TRACE_ADVANCE_PARAMS(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	updatetracelist(0)
	updatetracecontrols()
End
Function TRACE_CHECK(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	changetraceparams(ctrlName,checked,"")
	updatetracelist(0)
	updatetracecontrols()
End
Function TRACE_VAR(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	if(stringmatch(ctrlName,"TRACE_ADVANCE_*"))
		CheckBox TRACE_ADVANCE_COLOR_MIN_AUTO,value=0,win=GraphControl
		CheckBox TRACE_ADVANCE_COLOR_MAX_AUTO,value=0,win=GraphControl
		IMAGECOLORTABLE(ctrlName,varNum,"")
	endif
	changetraceparams(ctrlName,varNum,varStr)
End
//---removes selected trace(s)
Function TRACEREMOVE(this0all1other2) 
	variable this0all1other2
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	nvar MustUpdate
	variable	tnum,i,sel
	wave listselect
	string wavesST=""
	if((this0all1other2==0)&&(gettracenumber(-1)>=0))//---selected
		wavesST=stringfromlist(gettracenumber(-1),TraceNameList(WorkingPlotName(), ";", 1 ))
//		for(sel=0;sel<dimsize(listselect,0);sel++)
//			if(listselect[sel][0]>0)
//				wavesST+=stringfromlist(gettracenumber(-1),TraceNameList(WorkingPlotName(), ";", 1 ))+","
//			endif
//		endfor
	endif
	if(this0all1other2>0)	//---all
		wavesST=(replacestring(";",TraceNameList(WorkingPlotName(), ";", 1 ),","))	
		if(this0all1other2==2)	//---all other traces
			wavesST=removefromlist(stringfromlist(gettracenumber(-1),TraceNameList(WorkingPlotName(), ";", 1 )),wavesST,",")
		endif
		wavesST=removeending(wavesST)
	endif
	controlinfo/w=GraphControl PLOT_PRINT
	if(v_value)
		execute/p "removefromgraph /z /w="+WorkingPlotName()+" "+wavesST	
	else
		execute/q "removefromgraph /z /w="+WorkingPlotName()+" "+wavesST	
	endif	
	MustUpdate=1
	execute/p/q "GraphControlPanelUpdate()"
	setdatafolder DF
End

//---copies the trace appearance information
Function INFOCOPY(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	variable	found=0,tnum
	wave listselect	
	for (tnum=0;tnum<dimsize(listselect,0);tnum+=1)
		if ((listselect[tnum][0])&&(found==0))
			string tracename=stringfromlist(tnum,TraceNameList(WorkingPlotName(), ";", 1 ))
			string info=traceinfo(WorkingPlotName(),tracename,0)
			found=1
			string/g recreation=replacestring("RECREATION:",info[strsearch(info,"RECREATION",0),strlen(info)-1],"")
			if(stringmatch(info,"*errorbars:errorbars*"))
				recreation+=info[strsearch(info,"ERRORBARS:ErrorBars",0),strsearch(info,tracename,strsearch(info,"ERRORBARS:ErrorBars",0))-1]
				if(stringmatch(info,"*shade*"))
					recreation+=info[strsearch(info,"SHADE=",0),strsearch(info,"}",strsearch(info,"SHADE=",0))]
				endif
			endif
		endif
	endfor
	setdatafolder DF
End
//--pastes trace info saved before
Function INFOPASTE(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	nvar MustUpdate
	variable	tnum,i
	wave listselect
	svar recreation
	string st
	string printST
	for (tnum=0;tnum<dimsize(listselect,0);tnum+=1)
		printST=""
		if (listselect[tnum][0])
			string tracename=stringfromlist(tnum,TraceNameList(WorkingPlotName(), ";", 1 ))
			for(i=0;i<itemsinlist(recreation,";");i+=1)
				if(stringmatch(stringfromlist(i,recreation),"*errorbars:errorbars*"))//check that  error bars are present
					if(stringmatch(traceinfo(WorkingPlotName(),tracename,0),"*errorbars:errorbars*"))
						string ErrorOriginal=traceinfo(WorkingPlotName(),tracename,0)
						ErrorOriginal=ErrorOriginal[strsearch(ErrorOriginal,":ErrorBars",0)+1,strsearch(ErrorOriginal,";RECREATION",strsearch(ErrorOriginal,"ERRORBARS:ErrorBars",0))-1]
						string EWaveOriginal=ErrorOriginal[strsearch(ErrorOriginal,"wave=(",0),strsearch(ErrorOriginal,")",strsearch(ErrorOriginal,"wave=(",0))]
						if(stringmatch(stringfromlist(i,recreation),"*shade*"))//check that shaded error bars are present
							execute "ErrorBars "+tracename+replacestring("ERRORBARS:ErrorBars",stringfromlist(i,recreation)," ")+" "+EWaveOriginal
						else
							execute  "ErrorBars "+replacestring("ERRORBARS:ErrorBars",stringfromlist(i,recreation)," ")+" "+tracename+" Y,"+EWaveOriginal					
						endif
					
					endif
				else
					if(stringmatch(stringfromlist(i,recreation),"*(x)*"))
						execute  "ModifyGraph /w="+WorkingPlotName()+" "+replacestring("(x)",stringfromlist(i,recreation),"("+tracename+")")		
					endif
				endif
			endfor
			//execute/p/q "updatetracecontrols()"
			MustUpdate=1
		endif		
	endfor	
	execute/p/q "GraphControlPanelUpdate()"
	setdatafolder DF
End
//---copies trace  for other graphs
Function TRACECOPY(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	variable	tnum
	wave listselect
	make/o/t/n=0 tracecopyrecreation ,tracecopyY
	for (tnum=0;tnum<dimsize(listselect,0);tnum+=1)
		if (listselect[tnum][0])
			string tracename = stringfromlist(tnum,TraceNameList(WorkingPlotName(), ";", 1 ))
			insertpoints 0,1,tracecopyrecreation,tracecopyY
			tracecopyrecreation[0]="NAME:"+tracename+";"+traceinfo(WorkingPlotName(),tracename,0)
			tracecopyY[0]=GetWavesDataFolder(WaveRefIndexed(WorkingPlotName(), tnum, 1 ),2)
		endif
	endfor
	setdatafolder DF
End
//---paste the selected traces, used to duplicate traces to the same or other plots
function pastetrace(laxisname,baxisname)
	string laxisname,baxisname
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:	
	nvar MustUpdate
	wave/t  tracecopyrecreation ,tracecopyY
	wave listselect
	variable	tnum,location=itemsinlist(TraceNameList(WorkingPlotName(), ";", 1 )),i
	string recreation,laxis,baxis,tracename="",newtrace
	for (tnum=0;tnum<dimsize(listselect,0);tnum+=1)
		if(listselect[tnum][0]==1)
			location=tnum
			tracename=stringfromlist(tnum,tracenamelist(WorkingPlotName(),";",1))
		endif
	endfor
	for (tnum=numpnts(tracecopyY)-1;tnum>=0;tnum-=1)
		location+=1
		if(strlen(laxisname)==0)
			laxisname=stringbykey("YAXIS",tracecopyrecreation[tnum],":")
		endif
		if (stringmatch(laxisname,"*right*"))
			laxis="/R="+laxisname
		else
			laxis="/L="+laxisname
		endif
		if(strlen(baxisname)==0)
			baxisname=stringbykey("XAXIS",tracecopyrecreation[tnum],":")
		endif		
		if (stringmatch(baxisname,"*top*"))
			baxis="/T="+baxisname
		else
			baxis="/B="+baxisname
		endif		
		if(strlen(stringbykey("XWAVE",tracecopyrecreation[tnum],":")))
			execute/q "appendtograph "+laxis+baxis+" "+ tracecopyY[tnum]+" vs "+(stringbykey("XWAVEDF",tracecopyrecreation[tnum],":"))+(stringbykey("XWAVE",tracecopyrecreation[tnum],":"))
		else
			execute/q "appendtograph "+laxis+baxis +" "+ tracecopyY[tnum]
		endif
		//doupdate
		MustUpdate=1
		string newtracename=stringfromlist(itemsinlist(TraceNameList(WorkingPlotName(), ";", 1 ))-1,TraceNameList(WorkingPlotName(), ";", 1 ))

		updatetracelist(0)
		recreation=tracecopyrecreation[tnum]
		recreation=replacestring("RECREATION:",recreation[strsearch(recreation,"RECREATION",0),strlen(recreation)-1],"")
		for(i=0;i<itemsinlist(recreation,";");i+=1)
			if(stringmatch(stringfromlist(i,recreation),"*(x)*"))
				execute/q "ModifyGraph /w="+WorkingPlotName()+" "+replacestring("(x)",stringfromlist(i,recreation),"("+newtracename+")")		
			endif
		endfor
		recreation=StringByKey("ERRORBARS",  tracecopyrecreation[tnum])//tracecopyrecreation[tnum]
		tracename=StringByKey("NAME",  tracecopyrecreation[tnum])
		execute/q replacestring(tracename,recreation,newtracename,0,1)
	endfor	
	execute/p/q "GraphControlPanelUpdate()"
	setdatafolder DF
end

//---updates the selected traces according to the selected control
function changetraceparams(ctrlName,Num,Str)
	String ctrlName
	Variable Num
	String Str
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:
	variable tnum
	wave listselect//,Color3d,Color3dCol
	variable r,g,b
	string printST
	for (tnum=0;tnum<dimsize(listselect,0);tnum+=1)
		if (listselect[tnum][0]>0)
			string tracename=stringfromlist(tnum,TraceNameList(WorkingPlotName(), ";", 1 ))	
			if (stringmatch(ctrlName,"TRACEMAIN_MODE"))//mode style
				printST= " mode(" +tracename+")="+num2str(Num-1)
				execute/p/q "updatetracecontrols()"	
			endif

			if ((stringmatch(ctrlName,"TRACEMAIN_COL"))|| (stringmatch(ctrlName,"TRACEMAIN_COLTRANS")))//color
				controlinfo/w=graphcontrol TRACEMAIN_COL
				str=S_Value
				r=str2num(replacestring("(",stringfromlist(0,Str,","),""))
				g=str2num(stringfromlist(1,Str,","))
				b=str2num(stringfromlist(2,Str,","))
				controlinfo/w=graphcontrol TRACEMAIN_COLTRANS
				printST= " rgb("+tracename+")=("+num2str(r)+","+num2str(g)+","+num2str(b)+","+num2str(min(v_value*(256),65535))+")"
			endif	
			if (stringmatch(ctrlName,"*marker"))//marker type
				printST= " marker(" +tracename+")="+num2str(Num-1)			
			endif		
			if (stringmatch(ctrlName,"*filltypeplus"))//fill type+
				printST= " hbFill(" +tracename+")="+num2str(Num-1)			
			endif
			if (stringmatch(ctrlName,"*filltypeneg"))//fill type-
				printST= " useNegPat(" +tracename+")="+num2str(Num>1)			
				printST+= ";ModifyGraph/w="+WorkingPlotName()+" hBarNegFill(" +tracename+")="+num2str(Num-2)			
			endif			
			if (stringmatch(ctrlName,"*fillcolorplus"))//fill color check
				printST= " usePlusRGB(" +tracename+")="+num2str(Num)			
			endif
			if (stringmatch(ctrlName,"*fillcolorneg"))//fill color check
				printST= " usenegRGB(" +tracename+")="+num2str(Num)			
			endif
			if (stringmatch(ctrlName,"*colfillplus"))//fill color 
				printST= " plusRGB("+tracename+")="+Str
				CheckBox TRACE_FILLCOLORplus value=1,win=GraphControl
				printST+= ";ModifyGraph/w="+WorkingPlotName()+" usePlusRGB(" +tracename+")=1"		
			endif													
			if (stringmatch(ctrlName,"*colfillneg"))//fill color 
				printST=  " negRGB("+tracename+")="+Str
				CheckBox TRACE_FILLCOLORneg value=1,win=GraphControl
				printST+= ";ModifyGraph/w="+WorkingPlotName()+" usenegRGB(" +tracename+")=1"		
			endif													
			if (stringmatch(ctrlName,"*line"))//linestyle
				printST=  " lstyle(" +tracename+")="+num2str(Num-1)			
			endif	
			if (stringmatch(ctrlName,"*linesize"))//line size
				printST=  " lsize(" +tracename+")="+num2str(Num)			
			endif				
			if(stringmatch(ctrlName,"*MARKERSIZE"))//mode style
				printST=  " msize(" +tracename+")="+num2str(Num)			
			endif
			if(stringmatch(ctrlName,"*MARKERSKIP"))//mode style
				printST=  " mskip(" +tracename+")="+num2str(Num)			
			endif
			if (stringmatch(ctrlName,"*thick"))//stroke thick style
				printST=  " mrkThick(" +tracename+")="+num2str(Num)			
			endif	
			if (stringmatch(ctrlName,"TRACE_MARKERCOLSTROKE*"))//stroke color style
				ModifyGraph/w=$WorkingPlotName() useMrkStrokeRGB($tracename)=1
				controlinfo/w=graphcontrol TRACE_MARKERCOLSTROKE
				str=S_Value
				r=str2num(replacestring("(",stringfromlist(0,Str,","),""))
				g=str2num(stringfromlist(1,Str,","))
				b=str2num(stringfromlist(2,Str,","))
				controlinfo/w=graphcontrol TRACE_MARKERCOLSTROKETRANS
				printST=  "mrkStrokeRGB("+tracename+")=("+num2str(r)+","+num2str(g)+","+num2str(b)+","+num2str(min(v_value*(256),65535))+")"
				CheckBox TRACE_MARKERSTROKE value=1,win=GraphControl
			endif	
			if (stringmatch(ctrlName,"TRACE_MARKERSTROKE"))//stroke
				printST=  " useMrkStrokeRGB(" +tracename+")="+num2str(Num)			
			endif	
			if (stringmatch(ctrlName,"*opaque"))//stroke
				printST=  "opaque(" +tracename+")="+num2str(Num)			
			endif	
			//---advanced
			if (stringmatch(ctrlName,"*ADVANCE*"))//---z waves
				if( (stringmatch(ctrlName,"TRACE_ADVANCE_COLORTABLE_NAME"))||(stringmatch(ctrlName,"TRACE_ADVANCE_COLORTABLE_TRANS")) )//mode style
					controlinfo/w=GraphControl TRACE_ADVANCE_COLORTABLE_NAME
					string CTst=s_value

					controlinfo/w=GraphControl TRACE_ADVANCE_COLORTABLE_TRANS
					variable trans=v_value
					ModifyImage/w=GraphControl#ColorTableDisplay ColorTableShowWave ctab= {0,255,$"root:GraphControl:Colortables:TRANS"+num2str(trans)+":"+CTst,0}
					wave ColorTableMain=$"root:GraphControl:Colortables:TRANS"+num2str(trans)+":"+CTst

				endif

				if (stringmatch(ctrlName,"TRACE_ADVANCE_TOMODE"))//mode style
					printST= " tomode(" +tracename+")="+num2str(Num-1)
				else

					controlinfo/w=GraphControl TRACE_ADVANCE_SELECT
					variable found=0,zmode=v_value
					string execST="",ztype=""
					controlinfo/w=GraphControl TRACE_ADVANCE_ZWAVE
					string zwave=s_value
					if(zmode==1)//---color
						if(stringmatch(zwave,"_none_"))	//---remove z color wave
						 	printST=  "zColor(" +tracename+")=0"
						else	//---z color present
							found=1
							variable directRGB=0
							if(waveexists($zwave))
								if( (dimsize($zwave,1)==3)||(dimsize($zwave,1)==4))	//---direct RGB
									directRGB=1
								endif
							endif
							if(directRGB)
								execST="directRGB,0"
							else
								controlinfo /w=GraphControl TRACE_ADVANCE_COLORTABLE_NAME
								string colorTable=s_value
								controlinfo /w=GraphControl TRACE_ADVANCE_COLOR_REV
								variable rev=v_value	
								controlinfo/w=GraphControl TRACE_ADVANCE_COLORTABLE_TRANS
								variable transDF=v_value
								execST="ctableRGB,"+num2str(rev)+",root:graphcontrol:colortables:TRANS"+num2str(transDF)+":"+colorTable
							endif
						endif	
						ztype="zColor"
					endif
					if(zmode==2)//---marker size
						if(stringmatch(zwave,"_none_"))	//---remove z color wave
						 	printST=  " zmrkSize(" +tracename+")=0"
						else	//---z color presentctableRGBctableRGB
							found=1
							controlinfo /w=GraphControl TRACE_ADVANCE_MARK_MAX
							variable mrkmax=v_value
							controlinfo /w=GraphControl TRACE_ADVANCE_MARK_MIN
							variable mrkmin=v_value	
							execST=num2str(mrkmin)+","+num2str(mrkmax)
						endif	
						ztype="zmrkSize"
					endif
					if(zmode==3)//---marker type
						if(stringmatch(zwave,"_none_"))	//---remove z color wave
						 	printST=  "zmrkNum(" +tracename+")=0"
						else	//---z color present
						 	printST=  "zmrkNum(" +tracename+")={"+zwave+"}"
						endif	
					endif
	
					string minst="*",maxst="*"
					if(waveexists($zwave))				
						variable minval=wavemin($zwave)
						variable maxval=wavemax($zwave)
					else
						minval=0
						maxval=1
					endif	
					controlinfo /w=GraphControl TRACE_ADVANCE_COLOR_MIN_AUTO
					if(v_value)
						SetVariable TRACE_ADVANCE_COLOR_MIN,value=_num:minval,win=GraphControl				
					else
						controlinfo /w=GraphControl TRACE_ADVANCE_COLOR_MIN
						minst=num2str(v_value)
						CheckBox TRACE_ADVANCE_COLOR_MIN_AUTO,value=(v_value==minval),win=GraphControl
					endif
					controlinfo /w=GraphControl TRACE_ADVANCE_COLOR_MAX_AUTO
					if(v_value)
						SetVariable TRACE_ADVANCE_COLOR_MAX,value=_num:maxval,win=GraphControl				
					else
						controlinfo /w=GraphControl TRACE_ADVANCE_COLOR_MAX
						maxst=num2str(v_value)
						CheckBox TRACE_ADVANCE_COLOR_MAX_AUTO,value=(v_value==maxval),win=GraphControl
					endif
					if(found)
						printST=  ztype+"(" +tracename+")= {"+zwave+","+minst+","+maxst+","+execST+"}"
						if (stringmatch(ctrlName,"TRACE_ADVANCE_COLORTABLE_USE_COLOR_MIN"))//---min color style 
							if(Num==1)			//---like first
								printST+= ", zColorMin(" +tracename+")=0"
							elseif(Num==3)		//---transparent
								printST+= ", zColorMin(" +tracename+")=NaN"
							else					//---specific color
								controlinfo/w=GraphControl TRACE_ADVANCE_COLORTABLE_COLOR_MIN
								printST+= ", zColorMin(" +tracename+")="+s_value
							endif
						endif
						if (stringmatch(ctrlName,"TRACE_ADVANCE_COLORTABLE_COLOR_MIN"))//---min color style 
							printST+= ", zColorMin(" +tracename+")="+str 
						endif
						if (stringmatch(ctrlName,"TRACE_ADVANCE_COLORTABLE_USE_COLOR_MAX"))//---max color style 
							if(Num==1)			//---like first
								printST+= ", zColorMax(" +tracename+")=0"
							elseif(Num==3)		//---transparent
								printST+= ", zColorMax(" +tracename+")=NaN"
							else					//---specific color
								controlinfo/w=GraphControl TRACE_ADVANCE_COLORTABLE_COLOR_MAX
								printST+= ", zColorMax(" +tracename+")="+s_value
							endif
						endif
						if (stringmatch(ctrlName,"TRACE_ADVANCE_COLORTABLE_COLOR_MIN"))//---max color style 
							printST+= ", zColorMin(" +tracename+")="+str 
						endif

					endif
					
				endif
			endif
			//---offset
			if(stringmatch(ctrlName,"TRACE_OFFSET_*"))
				controlinfo/w=GraphControl TRACE_OFFSET_MULX
				string mulx=num2str(v_value)
				controlinfo/w=GraphControl TRACE_OFFSET_MULY
				string muly=num2str(v_value)
				controlinfo/w=GraphControl TRACE_OFFSET_X
				string offx=num2str(v_value)
				controlinfo/w=GraphControl TRACE_OFFSET_Y
				string offy=num2str(v_value)
				printST=  "offset("+tracename+")={"+offx+","+offy+"},muloffset("+tracename+")={"+mulx+","+muly+"}"		
			endif
		endif
		setdatafolder DF	
		if(strlen(printST)>0)
			//printST=replacestring(";", printST,",")
			controlinfo/w=GraphControl PLOT_PRINT
			if(v_value)
				execute/p "ModifyGraph/w="+WorkingPlotName()+" "+ printST
			else
				execute/q "ModifyGraph/w="+WorkingPlotName()+" "+printST
			endif
		endif	
	endfor
	setdatafolder DF	
	
end

//---user selection on tracelist listbox
Function TRACELIST(LB_Struct) : ListBoxControl
	STRUCT WMListboxAction &LB_Struct
	Variable row=LB_Struct.row
	Variable col=LB_Struct.col
	Variable event=LB_Struct.eventcode		
	string DF=getdatafolder(1)
	setdatafolder root:graphcontrol:
	nvar MustUpdate
	wave listselect 
	wave/t listtext,listtitle
	wave/wave ywaveref,xwaveref
	variable i,tnum,found
	variable/g selectedrow
	
	if ((event==1)&&(row>=-1))//mouse down, used for reorder	,replace waves
	//print event,row,LB_Struct.eventMod
		if(row<0)//---header
		elseif (row<=dimsize(listtext,0))	//---main body
			selectedrow=-1
			if(LB_Struct.eventMod==16)//---right mouse click,replace
				MustUpdate=1
				if (row<dimsize(listtext,0))
					if(stringmatch(listtitle[col],"Y axis"))
						PopupContextualMenu getaxistype(0)
						tracecopy("")
						traceremove(0)
						pastetrace(S_selection,"")

						//pastetrace(stringfromlist(V_flag-1,getaxistype(0)),"")
					endif
					if(stringmatch(listtitle[col],"X axis"))
						PopupContextualMenu getaxistype(1)
						tracecopy("")
						traceremove(0)
						pastetrace("",S_selection)
						//pastetrace("",stringfromlist(V_flag-1,getaxistype(1)))
					endif
				endif
				if(stringmatch(listtitle[col],"Y wave"))
					if (row<dimsize(listtext,0))
						PopupContextualMenu "Edit;Remove;Remove all;Remove other;Copy;Paste"
						if(stringmatch(S_selection,"Edit"))
							editwaves(listselect,row)
						endif
						if(stringmatch(S_selection,"Remove"))
							TRACEREMOVE(0)
						endif
						if(stringmatch(S_selection,"Remove all"))
							TRACEREMOVE(1)
						endif
						if(stringmatch(S_selection,"Remove other"))
							TRACEREMOVE(2)
						endif
						if(stringmatch(S_selection,"Copy"))
							tracecopy("")
						endif
						if(stringmatch(S_selection,"Paste"))
							pastetrace("","")
						endif
					else
					
					endif
				endif
				if (row<dimsize(listtext,0))
					if(stringmatch(listtitle[col],"X wave"))
						string info=traceinfo(WorkingPlotName(),stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 )),0)
						if (numberbykey("ISCAT",AxisInfo(WorkingPlotName(), stringbykey("XAXIS",info,":")),":"))	//---category
							PopupContextualMenu "Edit"
						else
							PopupContextualMenu "Edit;Remove"
						endif
						if(V_flag==1)
							editwaves(listselect,row)
						endif
						if(V_flag==2)
							execute "ReplaceWave/w="+WorkingPlotName()+"/X trace="+stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 ))+", $\"\" "
							updatetracelist(0)
						endif				
					endif
					if(stringmatch(listtitle[col],"* DF"))
						PopupContextualMenu "Set DF"
						execute /p "setdatafolder "+listtext[row][col]
					endif
				else
						PopupContextualMenu "Paste"
						if(V_flag)
							pastetrace("","")
						endif					
				endif
			else	
				//PopulateDFLists()
				//execute/p/q "PopulateDFLists("+num2str(row)+")"
			endif
		endif
	endif
	variable mousev
	if (event==4)//---mouse up
		if(row>=0)	
			MustUpdate=1
			if(stringmatch(listtitle[col],"Pos"))
				if(dimsize(listselect,0)>1)
					if((row<dimsize(listselect,0)-1))
						if((row==dimsize(listselect,0)-2))
							ReorderTraces /w=$WorkingPlotName() _front_, {$stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 ))}
						else
							ReorderTraces /w=$WorkingPlotName() $stringfromlist(row+2,TraceNameList(WorkingPlotName(), ";", 1 )), {$stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 ))}
						endif
					else
						ReorderTraces /w=$WorkingPlotName() _back_,{$stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 ))}
					endif
				endif
			endif
		endif		
	endif	
	if ((event==12))//---double click
		if(row==43)//---add
			//TRACEAPPEND("")
		endif
		if((row==127)||(row==43))//delete
			//TRACEREMOVE("")
		endif
	endif
	string newwave
	if (event==7)//---finish edit double click
		MustUpdate=1
		if(stringmatch(listtitle[col],"Y axis"))	
			string axisname=listtext[row][col]
			tracecopy("")
			traceremove(0)
			if(row<dimsize(listselect,0))
				listselect[row][0]=floor(listselect[row][0]/2)*2+1
			endif
			pastetrace(axisname,"")
		endif
		if(stringmatch(listtitle[col],"X axis"))	
			axisname=listtext[row][col]
			tracecopy("")
			traceremove(0)
			if(row<dimsize(listselect,0))
				listselect[row][0]=floor(listselect[row][0]/2)*2+1
			endif
			pastetrace("",axisname)
		endif		
		if(stringmatch(listtitle[col],"Y wave"))						
			newwave=GetWavesDataFolder(WaveRefIndexed(WorkingPlotName(), row, 1 ),1)+listtext[row][col]
			if(exists(newwave))
				listtext[row][col]=stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 ))
			else
				rename $GetWavesDataFolder(WaveRefIndexed(WorkingPlotName(), row, 1 ),2),$listtext[row][col]
			endif	
			//updatetracelist(0)	
		endif
		if(stringmatch(listtitle[col],"X wave"))						
			newwave=GetWavesDataFolder(XWaveRefFromTrace(WorkingPlotName(),stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 )) ),1)+listtext[row][col]
			if(exists(newwave))
				listtext[row][col]=nameofwave(XWaveRefFromTrace(WorkingPlotName(),stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 ))))
			else
				rename $GetWavesDataFolder(XWaveRefFromTrace(WorkingPlotName(),stringfromlist(row,TraceNameList(WorkingPlotName(), ";", 1 ))),2),$listtext[row][col]
			endif	
			//updatetracelist(0)	
		endif		
	endif
	if(numpnts(listselect)>0)
		//listselect=mod(listselect,2)
	endif
	setdatafolder $DF
	doupdate/w=graphcontrol
	SetVariable PLOT_FOLDER_CURRENTDF ,value= _STR:getdatafolder(1),win=GraphControl
//	execute/p/q "GraphControlPanelUpdate()"
	if(event==2)
		if(row<=dimsize(listselect,0)-1)	
			PopulateDFLists()
		endif
		UpdateFolderColors()
	endif	
	int err = GetRTError(0)
	if (err != 0)
		Printf "Stopping background task because of error %d\r", err
		return 1	
	endif
		
	return 0
End





//--------------------------------------------------------------------------//
//-----------------------------COLOR WHEEL
//--------------------------------------------------------------------------//


//Function to create the color wheel panel
Macro ColorWheelPlot()
	string DF=getdatafolder(1)
	dowindow /f GraphControlCW
	if(v_flag==0)
		newdatafolder/o/s root:GraphControl
		string/g ColorTableList
		newdatafolder/o/s ColorTables
		GCpopulateColorTables()
		newdatafolder/o/s root:GraphControl:colorwheel	 
		RecreateWaves()
		execute "InitGraphControlCW()"		
	endif
	setdatafolder $DF
end

//update of the controls on the CW panel
Function updateCWcontrols()
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	nvar NumColors,ColorMain,ColorSepAxis1,ColorSepAxis2,ColorBrightness	
	SetVariable AxisColor1,disable=(NumColors==1),win=GraphControlCW
	variable i
	for(i=1;i<=6;i+=1)
		PopupMenu $"ColorResult"+num2str(i) ,disable=1-(i<NumColors+1),win=GraphControlCW
		SetVariable $"ColorR"+num2str(i) noedit=0,disable=1-(i<NumColors+1),win=GraphControlCW
		SetVariable $"ColorG"+num2str(i) noedit=0,disable=1-(i<NumColors+1),win=GraphControlCW
		SetVariable $"ColorB"+num2str(i) noedit=0,disable=1-(i<NumColors+1),win=GraphControlCW
	endfor
	ColorMain=mod(ColorMain,12)
	ColorMain+=(ColorMain<0)*12

	if(NumColors==2)	//opposing colors, 6 separation
		ColorSepAxis1=6
	else
		ColorSepAxis1=min(ColorSepAxis1,(ceil(12/NumColors)+1))
	endif
	if(NumColors==3)	//triangle
		ColorSepAxis2=12-ColorSepAxis1*2
		SetVariable AxisColor1,limits={1,5,1},win=GraphControlCW

	endif
	if(NumColors==4)	//rectangle
		ColorSepAxis2=6-ColorSepAxis1
		SetVariable AxisColor1,limits={1,4,1},win=GraphControlCW
	endif	
	if(NumColors==6)	//heaxagon, 2 positions
		ColorSepAxis2=4-ColorSepAxis1
		SetVariable AxisColor1,limits={1,3,1},win=GraphControlCW
	endif	
	GroupBox IndividualColorsGB size={290,max(NumColors,4)*20+20}
	setdatafolder $DF
end

//---select a new color table
Function CWColorTabelPopMenuProc(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	drawCWshape()
End

////---update the WC display
//function UpdateCWPlot()
//end

//colors of the CW, circular about 12
Function/wave CWcol(location,Brightness)		
	variable location,Brightness
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:
	wave ColorTableShowWave
	setdatafolder root:GraphControl:colorwheel:
	wave/t  color_wheel_names
	make/o/n=3 col
	variable	location12=mod(location,12)
	location12+=(location12<0)*12
	controlinfo/w=GraphControlCW ColortableTypeTable
	if(v_value)	//---igor color table
		controlinfo/w=GraphControlCW ColorTableMenu 
		wave M_colors=root:graphcontrol:colortables:$s_value
		ModifyImage/w=GraphControlCW#ColorTableDisplay ColorTableShowWave ctab= {0,255,root:GraphControl:ColorTables:$(s_value),0}
		col=M_colors[floor(location12/12*dimsize(M_colors,0))][p]
		if(Brightness<3)
			col-=(col[p])*(3-Brightness)/6
		endif
		if(Brightness>3)
			col+=(65535-col[p])*(Brightness-3)/3
		endif	
	else 	//---color wheel
		execute "col=color_"+color_wheel_names[location12]+"["+num2str(Brightness)+"][p]"
	endif
	setdatafolder $DF
	return col
end

//draws the color selection
function drawCWshape()
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	wave/t color_wheel_names
	nvar NumColors,ColorMain,ColorSepAxis1,ColorSepAxis2,ColorBrightness	
	make/o/n=(NumColors+1) color_selection_drawX,color_selection_drawY
	variable location=ColorMain,i,location12,col,br
	for(i=0;i<NumColors;i+=1)		
		color_selection_drawX[i]=-(6-ColorBrightness)*sin(location/6*PI)
		color_selection_drawY[i]=(6-ColorBrightness)*cos(location/6*PI)
		PopupMenu $"ColorResult"+num2str(i+1) popColor=(CWcol(location,ColorBrightness)[0],CWcol(location,ColorBrightness)[1],CWcol(location,ColorBrightness)[2]),win=GraphControlCW
		SetVariable $"ColorR"+num2str(i+1) value=_NUM:floor(CWcol(location,ColorBrightness)[0]/256),win=GraphControlCW
		SetVariable $"ColorG"+num2str(i+1) value=_NUM:floor(CWcol(location,ColorBrightness)[1]/256),win=GraphControlCW
		SetVariable $"ColorB"+num2str(i+1) value=_NUM:floor(CWcol(location,ColorBrightness)[2]/256),win=GraphControlCW

		location+=mod(i+1,2)*ColorSepAxis1+mod(i,2)*ColorSepAxis2
	endfor
	color_selection_drawX[NumColors]=color_selection_drawX[0]
	color_selection_drawY[NumColors]=color_selection_drawY[0]
	//ModifyGraph marker(color_selection_drawY[0])=1
	//ModifyGraph/w=GraphControlCW#ColorWheelPlot 
	for(col=0;col<12;col++)
		make/o/n=(6,3) color_z
		for(br=0;br<6;br++)
			color_z[br][]=CWcol(col,br)[q]
		endfor
		duplicate/o color_z,$"color_z"+num2str(col)
		ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor($"CWschemeY"+num2str(col))={$"color_z"+num2str(col),*,*,directRGB}

	endfor	
	controlinfo/w=GraphControlCW ColortableUpdate
	if(v_value)
		CopyToTable()
	endif
	controlinfo/w=GraphControlCW ColortableUpdate3D
	if(v_value)
		CopyToTableBTN("CopyTo3D")
	endif	
	controlinfo/w=GraphControlCW ColortableUpdate3D_CT
	if(v_value)
		CopyToTableBTN("CopyTo3D_CT")
	endif	
	setdatafolder $DF

end

//shows the control of selected nodes
Function DisplayIndividualColors(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	
	//---update the popup window
	controlinfo/w=GraphControlCW ColorTableR
	variable r=v_value*256
	controlinfo/w=GraphControlCW ColorTableG
	variable g=v_value*256
	controlinfo/w=GraphControlCW ColorTableB
	variable b=v_value*256
	controlinfo/w=GraphControlCW ColorTableALPHA
	variable alpha=v_value*256
	PopupMenu ColorLocationPM popColor=(r,g,b,alpha),win=GraphControlCW
	wave ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR	,ColorTableMainAlpha
	controlinfo /w =GraphControlCW ColorLocations
	variable selLocation=v_value-1
	ColorTableMainR[selLocation]=r
	ColorTableMainG[selLocation]=g
	ColorTableMainB[selLocation]=b
	ColorTableMainAlpha[selLocation]=alpha	
	updateColorTableSlider(1)
	updateCWcontrols()
	drawCWshape()
	setdatafolder $DF
End


//--------------------------------------------color tables-----------------------------------------------

//calculates and shows the change in node position
function updateColorTableSlider(recalculate)
	variable recalculate
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	//nvar minscale,maxscale
	wave  ColorTableMain,ColorTableLocation
	controlinfo /w=GraphControlCW  ColorTableSlider1
	variable pos=min(v_value,100)
	if(recalculate)
		controlinfo /w =GraphControlCW ColorLocations
		variable selLocation=v_value-1,okchange=1			
		if(selLocation>0)
			ColorTableLocation[selLocation]=max(ColorTableLocation[selLocation-1]+1,ColorTableLocation[selLocation])
		endif
		if(selLocation<numpnts(ColorTableLocation)-1)
			ColorTableLocation[selLocation]=min(ColorTableLocation[selLocation+1]-1,ColorTableLocation[selLocation])
		endif
		ColorTableLocation[selLocation]=pos
		CalculateColorTable()
		UpdateSelectedLocation(selLocation)
	endif	
	//print pos
	Slider ColorTableSlider1 labelBack=(ColorTableMain(pos)[0],ColorTableMain(pos)[1],ColorTableMain(pos)[2],ColorTableMain(pos)[3]),win=GraphControlCW
	SetVariable ColorTableR value= _NUM:floor(ColorTableMain(pos)[0]/256),win=GraphControlCW
	SetVariable ColorTableG value= _NUM:floor(ColorTableMain(pos)[01]/256),win=GraphControlCW
	SetVariable ColorTableB value= _NUM:floor(ColorTableMain(pos)[02]/256),win=GraphControlCW
	SetVariable ColorTableALPHA value= _NUM:floor(ColorTableMain(pos)[03]/256),win=GraphControlCW
	PopupMenu ColorLocationPM popColor=(ColorTableMain(pos)[0],ColorTableMain(pos)[1],ColorTableMain(pos)[2],ColorTableMain(pos)[3]),win=GraphControlCW
	setdatafolder $DF
end




Function CopyToTable1()
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	
	nvar NumColors,ColorMain,ColorSepAxis1,ColorSepAxis2,ColorBrightness,Bright
	variable location=ColorMain,i,br
	variable BrLevels
	variable TotalColors
	if(Bright)
		BrLevels=(6- ColorBrightness)
	else
		BrLevels=ColorBrightness+1
	endif
	TotalColors=(NumColors)*(BrLevels*2)-NumColors+1
	Slider ColorTableSlider1 limits={0,TotalColors-2,1},win=GraphControlCW 
	make/o/n=(256,4) ColorTableMain=65535
	make/o/n=(256,10) ColorTableShow=p
	variable count=0
	for(i=0;i<NumColors;i+=1)			
		if(Bright)
			for(br=5;br>ColorBrightness;br-=1)	
				ColorTableMain[count][0,2]=CWcol(location,br)[q]
				count+=1
			endfor		
			for(br=ColorBrightness;br<6;br+=1)	
				ColorTableMain[count][0,2]=CWcol(location,br)[q]
				count+=1
			endfor
		else
			for(br=0;br<ColorBrightness;br+=1)	
				ColorTableMain[count][0,2]=CWcol(location,br)[q]
				count+=1
			endfor
			for(br=ColorBrightness;br>=0;br-=1)	
				ColorTableMain[count][0,2]=CWcol(location,br)[q]
				count+=1
			endfor			
		endif
		location+=mod(i+1,2)*ColorSepAxis1+mod(i,2)*ColorSepAxis2
	endfor	
	setdatafolder $DF
end

//takes the CW selection as nodes in color table
Function CopyToTable()
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:	
	nvar NumColors,ColorMain,ColorSepAxis1,ColorSepAxis2,ColorBrightness,Bright//,minscale,maxscale
	variable location=ColorMain,i,br
	variable BrStops,TotalColors=NumColors,DkStops,BetweenStopValue=0
	Slider ColorTableSlider1 limits={0,101,1},win=GraphControlCW 
	controlinfo/w=GraphControlCW ColortableBright
	BrStops=v_value
	if(BrStops)
		BetweenStopValue=5
	endif
	controlinfo/w=GraphControlCW ColortableDark
	DkStops=v_value	
	TotalColors+=(DkStops||BrStops)*(NumColors*2-2)

	make/o/n=(TotalColors) ColorTableMainR,ColorTableMainG,ColorTableMainB,ColorTableMainAlpha,ColorTableLocation=p/(TotalColors-1)*(100)
	make/o/n=(256,10) ColorTableShow=(q<5) ? p : -1

	variable count=0
	for(i=0;i<TotalColors;i+=1)	
		if((TotalColors==NumColors)||(mod(i,3)==0))
			ColorTableMainR[i]=CWcol(location,ColorBrightness)[0]
			ColorTableMainG[i]=CWcol(location,ColorBrightness)[1]
			ColorTableMainB[i]=CWcol(location,ColorBrightness)[2]
		else
			ColorTableMainR[i]=CWcol(location,BetweenStopValue)[0]
			ColorTableMainG[i]=CWcol(location,BetweenStopValue)[1]
			ColorTableMainB[i]=CWcol(location,BetweenStopValue)[2]		
		endif		
		count+=(TotalColors==NumColors)
		count+=(TotalColors>NumColors)*(mod(i+02,3)==0)	
		location=ColorMain+floor((count+1)/2)*ColorSepAxis1+floor(count/2)*ColorSepAxis2	
	endfor
	ColorTableMainAlpha=65535
	setdatafolder $DF
	CalculateColorTable()
end

//converts location to percent
//function LocationToPercent(input)
//	variable input
//	string DF=getdatafolder(1)
//	setdatafolder root:GraphControl:colorwheel:	
//	//nvar minscale,maxscale	
//	return (input-minscale)/(maxscale-minscale)*100
//	setdatafolder $DF
//end

//changes the scaling of the color tabel to 100 points
function/wave interpolateCT(ColorTableColor,ColorTableLocation)
	wave ColorTableColor,ColorTableLocation
	variable NumPoints=256
	variable i,pnt,startloc,endloc,loc
	make/o/n=(256) outputwave=ColorTableColor[numpnts(ColorTableLocation)-1]
	outputwave[0,ColorTableLocation[0]*2.56]=ColorTableColor[0]
	for (pnt=0;pnt<numpnts(ColorTableLocation)-1;pnt+=1)
		startloc=floor(ColorTableLocation[pnt]*2.56)
		endloc=floor(min(ColorTableLocation[pnt+1]*2.56,NumPoints-1))
		for (loc=(startloc);loc<(endloc);loc+=1)
			outputwave[loc]=(loc-startloc)/(endloc-startloc)*(ColorTableColor[pnt+1]-ColorTableColor[pnt])+ColorTableColor[pnt]
		endfor
	endfor
	return outputwave
end

//changes the scaling of the color table to 100 points
function CalculateColorTable()
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:	
	//nvar minscale,maxscale
	wave ColorTableMainR,ColorTableMainG,ColorTableMainB,ColorTableLocation,ColorTableMainAlpha
	make/o/n=(numpnts(ColorTableLocation)) ColorTableLocX=5
	make/o/n=256 CTMR,CTMG,CTMB,ColorTableScale
	
	make/o/n=(256,4) ColorTableMain
	make/o/n=(256,10) ColorTableShow=(q<5) ? p : -1
	SetScale/I x 00,100,"", ColorTableMain,ColorTableShow
	ColorTableScale=p*(100)/numpnts(ColorTableScale)
	ColorTableLocation=max(min(ColorTableLocation,100),0)
	sort ColorTableLocation,ColorTableLocation,ColorTableMainR,ColorTableMainG,ColorTableMainB,ColorTableMainAlpha
	duplicate/o  interpolateCT(ColorTableMainR,ColorTableLocation), CTMR
	duplicate/o  interpolateCT(ColorTableMainG,ColorTableLocation), CTMG
	duplicate/o  interpolateCT(ColorTableMainB,ColorTableLocation), CTMB
	duplicate/o  interpolateCT(ColorTableMainAlpha,ColorTableLocation), CTMALPHA
	ColorTableMain[][0]=CTMR[p]
	ColorTableMain[][1]=CTMG[p]
	ColorTableMain[][2]=CTMB[p]
	ColorTableMain[][3]=CTMALPHA[p]
	updateColorTableSlider(0)
	controlinfo/w=GraphControlCW ColortableUpdate3D_CT
	if(v_value)
		CopyToTableBTN("CopyTo3D_CT")
	endif		
	setdatafolder $DF
end

//helper function
Function/S ColorValList()
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	nvar NumColors
	wave ColorTableLocation
	string output=""
	Variable i
	for(i=0;i<numpnts(ColorTableLocation);i+=1)	
		output+=num2str(i+1)+";"
	endfor	
	setdatafolder $DF
	return output
end

//change in node location, chnages also the color of the slider
Function UpdateSelectedLocation(selLocation)
	variable selLocation
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	nvar NumColors
	wave ColorTableLocation	,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	Slider ColorTableSlider1 value= ColorTableLocation[selLocation],win=GraphControlCW
	updateColorTableSlider(0)
	SetVariable ColorLocationSV value= _NUM:ColorTableLocation[selLocation],win=GraphControlCW
	PopupMenu ColorLocationPM popColor=(ColorTableMainR[selLocation],ColorTableMainG[selLocation],ColorTableMainB[selLocation],ColorTableMainAlpha[selLocation]),win=GraphControlCW
	setdatafolder $DF
end

Function ColorLocationSelect(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	UpdateSelectedLocation(popNum-1)
End

Function ChangeCTLocation(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	variable selLocation
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	nvar NumColors//,maxscale,minscale
	wave ColorTableLocation
	controlinfo /w =GraphControlCW ColorLocations
	selLocation=v_value-1
	ColorTableLocation[selLocation]=varnum
	ColorTableLocation=max(min(ColorTableLocation,100),0)

	Slider ColorTableSlider1 value= ColorTableLocation[selLocation],win=GraphControlCW
	updateColorTableSlider(1)	
	setdatafolder $DF
End

Function SelectColorLocationPM(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	nvar NumColors
	wave ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR	,ColorTableMainAlpha
	controlinfo /w =GraphControlCW ColorLocations
	variable selLocation=v_value-1
	controlinfo /w =GraphControlCW ColorLocationPM
	ColorTableMainR[selLocation]=v_red
	ColorTableMainG[selLocation]=v_green
	ColorTableMainB[selLocation]=v_blue
	ColorTableMainAlpha[selLocation]=v_alpha
	setdatafolder $DF	
	CalculateColorTable()
End

//change in min or max scale
Function ScaleChanged(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	//nvar minscale,maxscale
	wave ColorTableLocation
	ColorTableLocation=max(min(ColorTableLocation,100),0)
	setdatafolder $DF
	CalculateColorTable()
	UpdateSelectedLocation(0)
End

//update color table as colors change
Function UpdateColorTable(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked	
	if(stringmatch(ctrlName,"*Type*"))
		CheckBox ColortableTypeColorWheel,value=0,win=GraphControlCW
		CheckBox ColortableTypeTable,value=0,win=GraphControlCW
	else
		CheckBox Colortableprimary,value=0,win=GraphControlCW
		CheckBox ColortableBright,value=0,win=GraphControlCW
		CheckBox ColortableDark,value=0,win=GraphControlCW
	endif
	CheckBox $ctrlName,value=1,win=GraphControlCW
	//CalculateColorTable()
	drawCWshape()
	//CopyToTable()
End

Function CopyToTableBTN(ctrlName) : ButtonControl
	String ctrlName
	if(stringmatch(ctrlName,"CopyToTable"))
		CopyToTable()
		PopupMenu ColorLocations mode=1,win=GraphControlCW
		UpdateSelectedLocation(0)
	else
		if(stringmatch(ctrlName,"CopyTo3D"))
			setwindow GraphControlCW,userdata(Source3d)="CT"
		else
			setwindow GraphControlCW,userdata(Source3d)=""
		endif
		GC3d_Orthogonal()
	endif
End

//the slider directs the nodes
Function ColorTableSlider(ctrlName,sliderValue,event) : SliderControl
	String ctrlName
	Variable sliderValue
	Variable event	// bit field: bit 0: value set, 1: mouse down, 2: mouse up, 3: mouse moved
	if(event %& 0x1)	// bit 0, value set
		updateColorTableSlider(1)
	endif
	int err = GetRTError(0)
	if (err != 0)
		Printf "Stopping background task because of error %d\r", err
		return 1	
	endif
	
	return 0
End

//increase the number of stop points
Function AddStop(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	wave ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	controlinfo /w =GraphControlCW ColorLocations
	variable selLocation=v_value-1,leftlocation,r,g,b,newlocation,alpha
	if(selLocation<numpnts(ColorTableLocation)-1)//insert new point between two existing points
		leftlocation=selLocation
	else	//insert new point before the last point
		leftlocation=selLocation-1
	endif		
	newlocation=ColorTableLocation[leftlocation]/2+ColorTableLocation[leftlocation+1]/2
	r=ColorTableMainR[leftlocation]/2+ColorTableMainR[leftlocation+1]/2
	g=ColorTableMainG[leftlocation]/2+ColorTableMainG[leftlocation+1]/2
	b=ColorTableMainB[leftlocation]/2+ColorTableMainB[leftlocation+1]/2	
	alpha=ColorTableMainAlpha[leftlocation]/2+ColorTableMainAlpha[leftlocation+1]/2	
	insertpoints 0,1, ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	ColorTableLocation[0]=newlocation
	ColorTableMainR[0]=r
	ColorTableMainG[0]=g
	ColorTableMainB[0]=b
	ColorTableMainAlpha[0]=alpha
	setdatafolder $DF
	CalculateColorTable()
	
	UpdateSelectedLocation(selLocation)
End

//---save selected gradient
Function SaveGradient(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	controlinfo/w=GraphControlCW NumGradient
	variable selGradientNum=v_value
	setdatafolder root:GraphControl:colorwheel:
	wave ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	duplicate/o ColorTableLocation,$"ColorTableLocation_"+num2str(selGradientNum)
	duplicate/o ColorTableMainB,$"ColorTableMainB_"+num2str(selGradientNum)
	duplicate/o ColorTableMainG,$"ColorTableMainG_"+num2str(selGradientNum)
	duplicate/o ColorTableMainR,$"ColorTableMainR_"+num2str(selGradientNum)
	duplicate/o ColorTableMainAlpha,$"ColorTableMainAlpha_"+num2str(selGradientNum)
	setdatafolder $DF
end	
//---load selected gradient
Function LoadGradient(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	controlinfo/w=GraphControlCW NumGradient
	variable selGradientNum=v_value
	setdatafolder root:GraphControl:colorwheel:
	if(waveexists($"ColorTableLocation_"+num2str(selGradientNum)))
		duplicate/o $"ColorTableLocation_"+num2str(selGradientNum),ColorTableLocation
		duplicate/o $"ColorTableMainB_"+num2str(selGradientNum),ColorTableMainB
		duplicate/o $"ColorTableMainG_"+num2str(selGradientNum),ColorTableMainG
		duplicate/o $"ColorTableMainR_"+num2str(selGradientNum),ColorTableMainR
		duplicate/o $"ColorTableMainAlpha_"+num2str(selGradientNum),ColorTableMainAlpha
	endif
	setdatafolder $DF
	CalculateColorTable()
	
	UpdateSelectedLocation(0)	
end	
	
//decrease the number of stop points
Function Delstop(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	wave ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	controlinfo /w =GraphControlCW ColorLocations
	variable selLocation=v_value-1
	if(numpnts(ColorTableLocation)>2)//can delete a point
		deletepoints selLocation,1,ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	endif

	
	CalculateColorTable()
	selLocation=min(selLocation,numpnts(ColorTableLocation)-1)
	//ColorValList()
	PopupMenu ColorLocations mode=selLocation+1,win=GraphControlCW
	UpdateSelectedLocation(selLocation)
	setdatafolder $DF
End

Function Export(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:GraphControl:colorwheel:
	wave ColorTableMain	
	svar CWname
	setdatafolder $DF
	variable ratio=dimsize(ColorTableMain,0)/256
	setdatafolder root:GraphControl:ColorTables
	make/o/n=(256,4) $CWname=ColorTableMain[p*ratio][q]
	GCcreateTransColorTables()
	setdatafolder $DF
End


Function InitGraphControlCW()
	String DF= GetDataFolder(1)
	NewPanel /K=1 /W=(43,0,509,500)/n=GraphControlCW
	GroupBox IndividualColorsGB,pos={166,2},size={290,100},title="Individual Colors",win=GraphControlCW
	SetVariable NumColors,pos={171,20},size={100,16},proc=DisplayIndividualColors,title="# Colors",win=GraphControlCW
	SetVariable NumColors,limits={1,4,1},value= root:GraphControl:colorwheel:NumColors,win=GraphControlCW
	SetVariable FirstColor,pos={171,40},size={100,16},proc=DisplayIndividualColors,title="First Color",win=GraphControlCW
	SetVariable FirstColor,limits={-1,12,1},value= root:GraphControl:colorwheel:ColorMain,win=GraphControlCW
	SetVariable AxisColor1,pos={171,80},size={100,16},proc=DisplayIndividualColors,title="Separation",win=GraphControlCW
	SetVariable AxisColor1,limits={1,5,1},value= root:GraphControl:colorwheel:ColorSepAxis1,win=GraphControlCW
	SetVariable Brightness,pos={171,60},size={100,16},proc=DisplayIndividualColors,title="Brightness",win=GraphControlCW
	SetVariable Brightness,limits={0,5,1},value= root:GraphControl:colorwheel:ColorBrightness,win=GraphControlCW
	PopupMenu ColorResult1,pos={279,17},size={50,21},win=GraphControlCW
	PopupMenu ColorResult1,mode=1,popColor= (65280,56832,5888),value= #"\"*COLORPOP*\"",win=GraphControlCW
	PopupMenu ColorResult2,pos={279,37},size={50,21},win=GraphControlCW
	PopupMenu ColorResult2,mode=1,popColor= (60672,7168,9216),value= #"\"*COLORPOP*\"",win=GraphControlCW
	PopupMenu ColorResult3,pos={279,57},size={50,21},win=GraphControlCW
	PopupMenu ColorResult3,mode=1,popColor= (8448,16384,39424),value= #"\"*COLORPOP*\"",win=GraphControlCW
	PopupMenu ColorResult4,pos={279,77},size={50,21},disable=1,win=GraphControlCW
	PopupMenu ColorResult4,mode=1,popColor= (0,floor(41216/256),floor(19200/256)),value= #"\"*COLORPOP*\"",win=GraphControlCW
	SetVariable ColorR1,pos={330,20},size={40,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorR1,limits={0,inf,0},value= _NUM:floor(65280/256),win=GraphControlCW
	SetVariable ColorG1,pos={370,20},size={40,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorG1,limits={0,inf,0},value= _NUM:floor(56832/256),win=GraphControlCW//,styledText= 1
	SetVariable ColorB1,pos={410,20},size={40,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorB1,limits={0,inf,0},value= _NUM:floor(5888/256),win=GraphControlCW//,styledText= 1
	SetVariable ColorR2,pos={330,40},size={40,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorR2,limits={0,inf,0},value= _NUM:floor(60672/256),win=GraphControlCW//,styledText= 1
	SetVariable ColorG2,pos={370,40},size={40,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorG2,limits={0,inf,0},value= _NUM:floor(7168/256),win=GraphControlCW//,styledText= 1
	SetVariable ColorB2,pos={410,40},size={40,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorB2,limits={0,inf,0},value= _NUM:floor(9216/256),win=GraphControlCW//,styledText= 1
	SetVariable ColorR3,pos={330,60},size={40,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorR3,limits={0,inf,0},value= _NUM:floor(8448/256),win=GraphControlCW//,styledText= 1
	SetVariable ColorG3,pos={370,60},size={40,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorG3,limits={0,inf,0},value= _NUM:floor(16384/256),win=GraphControlCW//,styledText= 1
	SetVariable ColorB3,pos={410,60},size={40,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorB3,limits={0,inf,0},value= _NUM:floor(39424/256),win=GraphControlCW//,styledText= 1
	SetVariable ColorR4,pos={330,80},size={40,16},disable=1,proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorR4,limits={0,inf,0},value= _NUM:0,win=GraphControlCW//,styledText= 1
	SetVariable ColorG4,pos={370,80},size={40,16},disable=1,proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorG4,limits={0,inf,0},value= _NUM:floor(41216/256),win=GraphControlCW//,styledText= 1
	SetVariable ColorB4,pos={410,80},size={40,16},disable=1,proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorB4,limits={0,inf,0},value= _NUM:floor(19200/256),win=GraphControlCW//,styledText= 1
//	PopupMenu ColorResult5,pos={279,97},size={50,21},disable=1,win=GraphControlCW
//	PopupMenu ColorResult5,mode=1,popColor= (floor(60672/256),floor(7168/256),floor(9216/256)),value= #"\"*COLORPOP*\"",win=GraphControlCW
//	SetVariable ColorR5,pos={330,100},size={40,16},disable=1,proc=DisplayIndividualColors,win=GraphControlCW
//	SetVariable ColorR5,limits={0,inf,0},value= _NUM:floor(60672/256),win=GraphControlCW
//	SetVariable ColorG5,pos={370,100},size={40,16},disable=1,proc=DisplayIndividualColors,win=GraphControlCW
//	SetVariable ColorG5,limits={0,inf,0},value= _NUM:floor(7168/256),win=GraphControlCW
//	SetVariable ColorB5,pos={410,100},size={40,16},disable=1,proc=DisplayIndividualColors,win=GraphControlCW
//	SetVariable ColorB5,limits={0,inf,0},value= _NUM:floor(9216/256),win=GraphControlCW
//	PopupMenu ColorResult6,pos={279,117},size={50,21},disable=1,win=GraphControlCW
//	PopupMenu ColorResult6,mode=1,popColor= (floor(25856/256),floor(11264/256),floor(30976/256)),value= #"\"*COLORPOP*\"",win=GraphControlCW
//	SetVariable ColorR6,pos={330,120},size={40,16},disable=1,proc=DisplayIndividualColors,win=GraphControlCW
//	SetVariable ColorR6,limits={0,inf,0},value= _NUM:floor(25856/256),win=GraphControlCW
//	SetVariable ColorG6,pos={370,120},size={40,16},disable=1,proc=DisplayIndividualColors,win=GraphControlCW
//	SetVariable ColorG6,limits={0,inf,0},value= _NUM:floor(11264/256),win=GraphControlCW
//	SetVariable ColorB6,pos={410,120},size={40,16},disable=1,proc=DisplayIndividualColors,win=GraphControlCW
//	SetVariable ColorB6,limits={0,inf,0},value= _NUM:floor(30976),win=GraphControlCW
	PopupMenu ColorTableMenu,pos={175,125},size={79.00,17.00},proc=CWColorTabelPopMenuProc,win=GraphControlCW
	PopupMenu ColorTableMenu,mode=1,value= #"root:GraphControl:colortablelist",win=GraphControlCW

	CheckBox ColortableTypeTable,pos={175,105},size={44.00,15.00},proc=UpdateColorTable,title="Table",win=GraphControlCW
	CheckBox ColortableTypeTable,value= 0,mode=1,win=GraphControlCW
	CheckBox ColortableTypeColorWheel,pos={380,105},size={81.00,15.00},proc=UpdateColorTable,title="Color Wheel",win=GraphControlCW
	CheckBox ColortableTypeColorWheel,value= 1,mode=1,win=GraphControlCW

	Button CopyToTable,pos={255,155},size={120,30},proc=CopyToTableBTN,title="Copy to Color Table",win=GraphControlCW
	CheckBox ColortableUpdate,pos={380,162},size={53,14},title="Live update",win=GraphControlCW
	Button CopyTo3D,pos={255.00,190.00},size={120.00,30.00},proc=CopyToTableBTN,title="Copy to 3D",win=GraphControlCW
	CheckBox ColortableUpdate3D,pos={380.00,197.00},size={73.00,16.00},title="Live update",value= 1,win=GraphControlCW

	//---resulting color table
	variable positionY=144+80
	GroupBox ColorTables,pos={166,positionY},size={290,274},title="Color Table",win=GraphControlCW
	Slider ColorTableSlider1,pos={208,positionY+125},size={220,19},proc=ColorTableSlider,win=GraphControlCW
	Slider ColorTableSlider1,labelBack=(floor(65280/256),floor(56832/256),floor(5888/256)),win=GraphControlCW
	Slider ColorTableSlider1,limits={0,101,1},value= 0,side= 2,vert= 0,ticks= 0,win=GraphControlCW
//	PopupMenu ColorTableMenu,pos={250.00,105.00},size={206.00,19.00},proc=CWColorTabelPopMenuProc,title=" "
//	PopupMenu ColorTableMenu,mode=49,value= #"\"*COLORTABLEPOP*\""

	
	PopupMenu ColorLocations,pos={176,positionY+19},size={113,21},proc=ColorLocationSelect,title="Gradient Stop #",win=GraphControlCW
	PopupMenu ColorLocations,mode=1,popvalue="1",value= #"ColorValList()",win=GraphControlCW
	SetVariable ColorTableR,pos={175,positionY+71},size={60,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorTableR,limits={0,255,1},value= _NUM:floor(65280/256),win=GraphControlCW
	SetVariable ColorTableG,pos={235,positionY+71},size={60,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorTableG,limits={0,255,1},value= _NUM:floor(56832/256),win=GraphControlCW
	SetVariable ColorTableB,pos={295,positionY+71},size={60,16},proc=DisplayIndividualColors,win=GraphControlCW
	SetVariable ColorTableB,limits={0,255,1},value= _NUM:floor(5888/256),win=GraphControlCW
	SetVariable ColorTableAlpha,pos={365,positionY+71},size={80.00,18.00},proc=DisplayIndividualColors,title="α",win=GraphControlCW
	SetVariable ColorTableAlpha,limits={0,255,1},value= _NUM:256,win=GraphControlCW

	SetVariable ColorLocationSV,pos={231,positionY+50},size={90,16},proc=ChangeCTLocation,title="Position",win=GraphControlCW
	SetVariable ColorLocationSV,value= _NUM:0,win=GraphControlCW
	PopupMenu ColorLocationPM,pos={175,positionY+47},size={50,21},proc=SelectColorLocationPM,win=GraphControlCW
	PopupMenu ColorLocationPM,mode=1,popColor= (65280,56832,5888),value= #"\"*COLORPOP*\"",win=GraphControlCW
//	SetVariable MinScale,pos={171,313},size={70,16},proc=ScaleChanged,title="Min:"
//	SetVariable MinScale,value= root:GraphControl:colorwheel:minscale
//	SetVariable MaxScale,pos={380,313},size={70,16},proc=ScaleChanged,title="Max:"
//	SetVariable MaxScale,value= root:GraphControl:colorwheel:maxscale
	Button AddGradientStop,pos={367,positionY+20},size={32,32},proc=AddStop,title="Add",win=GraphControlCW
	Button RemoveGradientStop,pos={407,positionY+20},size={32,32},proc=Delstop,title="Del",win=GraphControlCW
	CheckBox Colortableprimary,pos={180,positionY+96},size={108,14},proc=UpdateColorTable,title="Primary Only",win=GraphControlCW
	CheckBox Colortableprimary,value= 1,mode=1,win=GraphControlCW
	CheckBox ColortableBright,pos={280,positionY+96},size={97,14},proc=UpdateColorTable,title="+ Bright",win=GraphControlCW
	CheckBox ColortableBright,value= 0,mode=1,win=GraphControlCW
	CheckBox ColortableDark,pos={360,positionY+96},size={93,14},proc=UpdateColorTable,title="+ Dark",win=GraphControlCW
	CheckBox ColortableDark,value= 0,mode=1,win=GraphControlCW
	Button Export,pos={172,positionY+205},size={60,30},proc=Export,title="Export",win=GraphControlCW
	SetVariable ColorTableName,pos={235,positionY+213},size={214,16},noproc,title="Name:",win=GraphControlCW
	SetVariable ColorTableName,limits={0,inf,0},value= root:GraphControl:colorwheel:CWname,win=GraphControlCW
	Button SaveGradient,pos={290,positionY+171},size={50.00,32.00},proc=SaveGradient,title="Save",win=GraphControlCW
	SetVariable NumGradient,pos={180,positionY+176},size={100.00,18.00},title="Gradient #",win=GraphControlCW
	SetVariable NumGradient,limits={1,inf,1},value= _NUM:1,win=GraphControlCW
	Button LoadGradient,pos={350,positionY+171},size={50.00,32.00},proc=LoadGradient,title="Load",win=GraphControlCW
	Button CopyTo3D_CT,pos={172.00,462.00},size={120.00,30.00},proc=CopyToTableBTN,title="Copy to 3D",win=GraphControlCW
	CheckBox ColortableUpdate3D_CT,pos={297.00,469.00},size={73.00,16.00},title="Live update",value= 0,win=GraphControlCW

	//---3d controls
	SetVariable Color3D_position,pos={10.00,325.00},size={90.00,19.00},proc=CW_3dColor_SetVarProc,title="Position",win=GraphControlCW
	SetVariable Color3D_position,limits={0,100,1},value= _NUM:50,win=GraphControlCW
	SetVariable Color3D_distance,pos={10.00,375.00},size={90.00,19.00},proc=CW_3dColor_SetVarProc,title="Distance",win=GraphControlCW
	SetVariable Color3D_distance,limits={0,inf,1},value= _NUM:50,win=GraphControlCW
	CheckBox Color3D_Orthogonal,pos={5.00,357.00},size={73.00,16.00},proc=CW_3dColor_CheckProc,title="Orthogonal",win=GraphControlCW
	CheckBox Color3D_Orthogonal,value= 1,win=GraphControlCW
	CheckBox Color3D_Negative,pos={5.00,427.00},size={59.00,16.00},proc=CW_3dColor_CheckProc,title="Negative",win=GraphControlCW
	CheckBox Color3D_Negative,value= 1,win=GraphControlCW
	CheckBox Color3D_NegativeLine,pos={5.00,457.00},size={84.00,16.00},proc=CW_3dColor_CheckProc,title="Negative Line",win=GraphControlCW
	CheckBox Color3D_NegativeLine,value= 1,win=GraphControlCW
	SetVariable Color3D_NegPos,pos={10.00,475.00},size={90.00,19.00},proc=CW_3dColor_SetVarProc,title="Position",win=GraphControlCW
	SetVariable Color3D_NegPos,limits={0,100,10},value= _NUM:50,win=GraphControlCW
	ValDisplay Color3d_NegLineCol,pos={110.00,458.00},size={50.00,14.00},frame=2,win=GraphControlCW
	ValDisplay Color3d_NegLineCol,limits={0,1,0},barmisc={0,0},mode= 2,zeroColor= (32768,32768,32768),win=GraphControlCW
	ValDisplay Color3d_NegLineCol,value= #"0",win=GraphControlCW
	ValDisplay Color3d_NegCol,pos={110.00,428.00},size={50.00,14.00},frame=2,win=GraphControlCW
	ValDisplay Color3d_NegCol,limits={0,1,0},barmisc={0,0},mode= 2,zeroColor= (39424,20480,14336),win=GraphControlCW
	ValDisplay Color3d_NegCol,value= #"0",win=GraphControlCW
	ValDisplay Color3d_PositionCol,pos={110.00,328.00},size={50.00,14.00},frame=2,win=GraphControlCW
	ValDisplay Color3d_PositionCol,limits={0,1,0},barmisc={0,0},mode= 2,zeroColor= (26112,45056,51200),win=GraphControlCW
	ValDisplay Color3d_PositionCol,value= #"0",win=GraphControlCW
	SetVariable Color3D_Angle,pos={10.00,395.00},size={90.00,19.00},proc=CW_3dColor_SetVarProc,title="Angle",win=GraphControlCW
	SetVariable Color3D_Angle,limits={0,330,30},value= _NUM:0,win=GraphControlCW
	ValDisplay Color3d_OrthoCol,pos={110.00,358.00},size={50.00,14.00},frame=2,win=GraphControlCW
	ValDisplay Color3d_OrthoCol,limits={0,1,0},barmisc={0,0},mode= 2,zeroColor= (24245,34268,44919),win=GraphControlCW
	ValDisplay Color3d_OrthoCol,value= #"0",win=GraphControlCW
	
//	SetVariable NumPoints,pos={250.00,335.00},size={150.00,18.00},proc=ScaleChanged,title="Number of points:"
//	SetVariable NumPoints,format="%d",limits={1,inf,1},value= _NUM:100
	//---end variables
	
	//---color wheel plot
	NewDAtaFolder/s/o root:GraphControl:colorwheel
	wave color_selection_drawY,color_selection_drawX,ColorTableShow
	wave ColorTableLocX,ColorTableLocation
	Display/W=(0,0,160,160)/HOST=GraphControlCW/n=ColorWheelPlot
	variable i
	for(i=0;i<12;i++)
		AppendToGraph/w=GraphControlCW#ColorWheelPlot $"CWschemeY"+num2str(i) vs $"CWschemeX"+num2str(i)
	endfor

	AppendToGraph/w=GraphControlCW#ColorWheelPlot color_selection_drawY vs color_selection_drawX
	ModifyGraph/w=GraphControlCW#ColorWheelPlot margin(left)=20,margin(bottom)=20,margin(top)=20,margin(right)=20,width=120,height=120,mode=4

	ModifyGraph/w=GraphControlCW#ColorWheelPlot marker=19,nticks=0,axThick=0
	ModifyGraph/w=GraphControlCW#ColorWheelPlot marker(color_selection_drawY)=41
	ModifyGraph/w=GraphControlCW#ColorWheelPlot lStyle(color_selection_drawY)=2
	ModifyGraph/w=GraphControlCW#ColorWheelPlot rgb(color_selection_drawY)=(65535,0,0)
	ModifyGraph/w=GraphControlCW#ColorWheelPlot msize=4
	ModifyGraph/w=GraphControlCW#ColorWheelPlot msize(color_selection_drawY)=6
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY0)={root:GraphControl:ColorWheel:color_yellow,*,*,directRGB},zColor(CWschemeY1)={root:GraphControl:ColorWheel:color_yellow_orange,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY2)={root:GraphControl:ColorWheel:color_orange,*,*,directRGB},zColor(CWschemeY3)={root:GraphControl:ColorWheel:color_red_orange,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY4)={root:GraphControl:ColorWheel:color_red,*,*,directRGB},zColor(CWschemeY5)={root:GraphControl:ColorWheel:color_red_purple,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY6)={root:GraphControl:ColorWheel:color_purple,*,*,directRGB},zColor(CWschemeY7)={root:GraphControl:ColorWheel:color_blue_purple,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY8)={root:GraphControl:ColorWheel:color_blue,*,*,directRGB},zColor(CWschemeY9)={root:GraphControl:ColorWheel:color_blue_green,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY10)={root:GraphControl:ColorWheel:color_green,*,*,directRGB},zColor(CWschemeY11)={root:GraphControl:ColorWheel:color_yellow_green,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot marker(color_selection_drawY[0])=1

	//---color table scale
	display/W=(207,positionY+145,427,positionY+165)/HOST=GraphControlCW /n=ColorTableScale 
	appendImage/w=GraphControlCW#ColorTableScale ColorTableShow
	AppendToGraph/w=GraphControlCW#ColorTableScale ColorTableLocX vs ColorTableLocation
	AppendToGraph/w=GraphControlCW#ColorTableScale ColorTableLocX vs ColorTableLocation
	ModifyGraph/w=GraphControlCW#ColorTableScale margin(left)=10,margin(bottom)=-1,margin(top)=-1,margin(right)=10,width=200,height=15,nticks=0,axThick=0
	ModifyGraph/w=GraphControlCW#ColorTableScale mode(ColorTableLocX)=3,marker(ColorTableLocX)=23
	ModifyGraph/w=GraphControlCW#ColorTableScale mode(ColorTableLocX#1)=3,marker(ColorTableLocX#1)=10,msize(ColorTableLocX#1)=3,rgb(ColorTableLocX#1)=(65535,65535,65535)
	ModifyGraph/w=GraphControlCW#ColorTableScale msize(ColorTableLocX)=5
	ModifyGraph/w=GraphControlCW#ColorTableScale useMrkStrokeRGB(ColorTableLocX)=1
	ModifyImage/w=GraphControlCW#ColorTableScale ColorTableShow ctab= {0,*,root:GraphControl:ColorWheel:ColorTableMain,0}	,minRGB=NaN,maxRGB=0
	ModifyGraph/w=GraphControlCW#ColorTableScale zColor(ColorTableLocX)={root:GraphControl:ColorWheel:ColorTableLocation,*,*,cindexRGB,0,root:GraphControl:ColorWheel:ColorTableMain}
   //---color table displays
   newimage/host=GraphControlCW /n=ColorTableDisplay root:GraphControl:ColorTableShowWave
   movesubwindow/w=GraphControlCW#ColorTableDisplay fnum=(235,105,365,125)
    controlinfo/w=GraphControlCW ColorTableMenu
	ModifyImage/w=GraphControlCW#ColorTableDisplay ColorTableShowWave ctab= {0,255,root:GraphControl:ColorTables:$(s_value),0}
	ModifyGraph/w=GraphControlCW#ColorTableDisplay margin=5, nticks=0,axThick=0
	setwindow GraphControlCW hook(click)=ColorTableClickHook
	setwindow GraphControlCW activeChildFrame=0
	//---3d color-------------
	newgizmo/host=GraphControlCW /n=GizmoColor3D/w=(0,162,161,161+160)
//	movesubwindow /w=GraphControlCW#GizmoColor3D fnum=(0,162,161,400)
	GC3d_Orthogonal()
	//---axes
	AppendToGizmo /n=GraphControlCW#GizmoColor3D Axes=BoxAxes,name=axesBox
	for(i=0;i<12;i++)
		ModifyGizmo /n=GraphControlCW#GizmoColor3D ModifyObject=axesBox,objectType=Axes,property={ i,axisColor,1,0,0,1}
	endfor
	for(i=2;i<=5;i++)
		ModifyGizmo /n=GraphControlCW#GizmoColor3D ModifyObject=axesBox,objectType=Axes,property={ i,axisColor,0,0,1,1}
	endfor
	for(i=6;i<=8;i++)
		ModifyGizmo /n=GraphControlCW#GizmoColor3D ModifyObject=axesBox,objectType=Axes,property={ i,axisColor,0,1,0,1}
	endfor
	ModifyGizmo /n=GraphControlCW#GizmoColor3D ModifyObject=axesBox,objectType=Axes,property={ 1,axisColor,0,1,0,1}
	ModifyGizmo /n=GraphControlCW#GizmoColor3D resumeUpdates
	//---grid 
	AppendToGizmo/n=GraphControlCW#GizmoColor3D  Scatter=root:GraphControl:ColorGrid,name=scatterGrid
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterGrid,objectType=scatter,property={ scatterColorType,1}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterGrid,objectType=scatter,property={ markerType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterGrid,objectType=scatter,property={ sizeType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterGrid,objectType=scatter,property={ rotationType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterGrid,objectType=scatter,property={ Shape,2}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterGrid,objectType=scatter,property={ size,.2}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterGrid,objectType=scatter,property={ colorWave,root:GraphControl:ColorGridCol}
	//---color scale scatter
	AppendToGizmo/n=GraphControlCW#GizmoColor3D  Scatter=root:GraphControl:Color3d,name=scatterCT
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterCT,objectType=scatter,property={ scatterColorType,1}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterCT,objectType=scatter,property={ markerType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterCT,objectType=scatter,property={ sizeType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterCT,objectType=scatter,property={ rotationType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterCT,objectType=scatter,property={ Shape,2}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterCT,objectType=scatter,property={ size,.5}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  ModifyObject=scatterCT,objectType=scatter,property={ colorWave,root:GraphControl:Color3dCol}
	//---orthogonal space
	AppendToGizmo/n=GraphControlCW#GizmoColor3D Scatter=root:GraphControl:Ortho3d,name=scatterOrthogonal
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterOrthogonal,objectType=scatter,property={ scatterColorType,1}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterOrthogonal,objectType=scatter,property={ markerType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterOrthogonal,objectType=scatter,property={ sizeType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterOrthogonal,objectType=scatter,property={ rotationType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterOrthogonal,objectType=scatter,property={ Shape,2}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterOrthogonal,objectType=scatter,property={ size,01}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterOrthogonal,objectType=scatter,property={ colorWave,root:GraphControl:Ortho3dCol}
	//---negative (opposite color)
	AppendToGizmo/n=GraphControlCW#GizmoColor3D Scatter=root:GraphControl:Neg3D,name=scatterNegative
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegative,objectType=scatter,property={ scatterColorType,1}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegative,objectType=scatter,property={ markerType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegative,objectType=scatter,property={ sizeType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegative,objectType=scatter,property={ rotationType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegative,objectType=scatter,property={ Shape,2}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegative,objectType=scatter,property={ size,0.5}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegative,objectType=scatter,property={ colorWave,root:GraphControl:Neg3DCol}
	//---line to negative
	AppendToGizmo/n=GraphControlCW#GizmoColor3D Scatter=root:GraphControl:Neg3dLine,name=scatterNegativeLine
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegativeLine,objectType=scatter,property={ scatterColorType,1}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegativeLine,objectType=scatter,property={ markerType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegativeLine,objectType=scatter,property={ sizeType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegativeLine,objectType=scatter,property={ rotationType,0}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegativeLine,objectType=scatter,property={ Shape,2}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegativeLine,objectType=scatter,property={ size,0.5}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D ModifyObject=scatterNegativeLine,objectType=scatter,property={ colorWave,root:GraphControl:Neg3dLineCol}
	//---display the objects
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  setDisplayList=0, object=scatterCT
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  setDisplayList=1, object=scatterOrthogonal
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  setDisplayList=2, object=scatterNegative
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  setDisplayList=3, object=scatterNegativeLine
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  setDisplayList=4, object=axesBox
	ModifyGizmo/n=GraphControlCW#GizmoColor3D  setDisplayList=5, object=scatterGrid
	ModifyGizmo/n=GraphControlCW#GizmoColor3D currentGroupObject=""
	ModifyGizmo /n=GraphControlCW#GizmoColor3D setOuterBox={0,255,0,255,0,255}
	ModifyGizmo/n=GraphControlCW#GizmoColor3D scalingOption=0
   execute/p/q "CopyToTableBTN(\"CopyToTable\")"
   execute/p/q "CopyToTableBTN(\"CopyTo3D_CT\")"
   
	SetDataFolder $DF
   
EndMacro

Function CW_3dColor_CheckProc(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked
	GC3d_Orthogonal()
End

Function CW_3dColor_SetVarProc(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	GC3d_Orthogonal()
End


//---create the 3d representaiton of colortables
Function GC3d_Orthogonal()
	dowindow GraphControlCW
	if(v_flag)
		controlinfo/w=GraphControlCW Color3D_position
		variable point=max(1,v_value/100*256)
		controlinfo/w=GraphControlCW Color3D_distance
		variable dist=v_value
		controlinfo/w=GraphControlCW Color3D_orthogonal
		variable doOrth=v_value
		controlinfo/w=GraphControlCW Color3D_negative
		variable doNeg=v_value
		controlinfo/w=GraphControlCW Color3D_negativeLine
		variable doNegLine=v_value

		variable doGrid=0
		string DF=getdatafolder(1)
		setdatafolder root:graphcontrol:ColorWheel
		wave colorTableMain
		setdatafolder root:graphcontrol:
 		make/o/n=(11^3,3) ColorGrid=(((q==0)*mod(p,11)*255/10+(q==1)*floor(mod(p,121)/11)*255/10+(q==2)*floor(p/121)*255/10))*doGrid
		make/o/n=(11^3,4) ColorGridCol=doGrid
		ColorGridCol[][0,2]=ColorGrid[p][q]/256
		variable CT=stringmatch(getuserdata("GraphControlCW","","Source3d"),"CT")
		if(CT)
			controlinfo/w=GraphControlCW ColorTableMenu 
			wave M_colors=root:graphcontrol:colortables:$s_value
			make/o/n=(256,3) color3d=M_colors[p][q]/256
		else
			make/o/n=(256,3) color3d=colortablemain[p][q]/256
		endif
		make/o/n=(256,4) Color3dCol=1
		Color3dCol[][0,2]=Color3d[p][q]/256
		make/o/n=(3) ColVec=Color3d[point][p]-Color3d[point-1][p]
		make/o/n=(1,3) Ortho3d=0
		//---orthogonal circle
		if(doOrth)
			variable angle1=atan2(ColVec[1],ColVec[0])
			variable angle2=atan2(ColVec[2],sqrt(ColVec[1]^2+ColVec[0]^2))
			
			variable i
			make/o/n=3/free VecN1=0,VecN2
			VecN1[0]=-sin(angle1)*cos(angle2)
			VecN1[1]=cos(angle1)*cos(angle2)
			VecN1[2]=0//abs(cos(angle2))<0.1
			
			VecN2[0]=-cos(angle1)*sin(angle2)
			VecN2[1]=-sin(angle1)*sin(angle2)
			VecN2[2]=cos(angle2)

//			print angle1,angle2,VecN1,VecN2,ColVec
			if(sqrt(VecN1[0]^2+VecN1[1]^2)<0.1)	//---zero vector
				VecN1[0]=VecN2[1]
				VecN1[1]=VecN2[0]
			endif
			for(i=0;i<360;i+=30)
				insertpoints 0,1,Ortho3d
				Ortho3d[0][] = dist*( cos(i/180*PI)*(VecN1[q])+sin(i/180*PI)*(VecN2[q]) )

			endfor		
		endif
		ValDisplay Color3d_PositionCol zeroColor= (min(65535,Color3d[point][0]*256),min(65535,Color3d[point][1]*256),min(65535,Color3d[point][2]*256)),win=GraphControlCW

		Ortho3d+=Color3d[point][q]
		if(doOrth)
			controlinfo/w=GraphControlCW Color3D_Angle
			variable angle=v_value/30
			ValDisplay Color3d_OrthoCol zeroColor= (min(65535,Ortho3d[angle][0]*256),min(65535,Ortho3d[angle][1]*256),min(65535,Ortho3d[angle][2]*256)),win=GraphControlCW
		else
			ValDisplay Color3d_OrthoCol zeroColor= (61166,61166,61166),win=GraphControlCW
		endif
		//---negative
		make/o/n=(256,3) Neg3D=256-Color3d[p][q]
		make/o/n=(256,4) Neg3DCol=1
		Neg3DCol[][0,2]=Neg3D/256
		
		//---negative line
		if(doNegLine)
			make/o/n=(10,3) Neg3dLine=Color3d[point][q]*p/10+Neg3D[point][q]*(10-p)/10
			make/o/n=(10,4) Neg3dLineCol=1
			Neg3dLineCol[][0,2]=Neg3dLine/256
			controlinfo/w=GraphControlCW Color3D_negPos
			insertpoints 0,1,Ortho3d
			Ortho3d[0][]=Neg3dLine[v_value/100*9][q]
			//---update the display
			ValDisplay Color3d_NegLineCol zeroColor= (min(65535,Ortho3d[0][0]*256),min(65535,Ortho3d[0][1]*256),min(65535,Ortho3d[0][2]*256)),win=GraphControlCW
		else
			Neg3dLine=nan
			ValDisplay Color3d_NegLineCol zeroColor= (61166,61166,61166),win=GraphControlCW
		endif
		if(doNeg)
			insertpoints 0,1,Ortho3d
			Ortho3d[0][]=Neg3D[point][q]
			ValDisplay Color3d_NegCol zeroColor= (min(65535,Ortho3d[0][0]*256),min(65535,Ortho3d[0][1]*256),min(65535,Ortho3d[0][2]*256)),win=GraphControlCW
		else
			Neg3D=nan
			ValDisplay Color3d_NegCol zeroColor= (61166,61166,61166),win=GraphControlCW
		endif
		make/o/n=(dimsize(Ortho3d,0),4) Ortho3dCol=1
		Ortho3dCol[][0,2]=Ortho3d[p][q]/256
		setdatafolder DF
	endif
end

//used to save all the waves and variables in a data folder
Function DataFolderList()
	killwaves/z TempWave,TempWaveTxt
	string ThisWave="test",data="",waves=WaveList("*",";","")//WaveList("*",";","TEXT:0")
	variable objects
	for (objects=0;objects<itemsinlist( waves);objects+=1)
		ThisWave=stringfromlist(objects,waves)
		if(wavetype($ThisWave,1)==1)//numeric
			duplicate /o $ThisWave, TempWave
			data="make/o /n=("+num2str(dimsize($ThisWave,0))+","+num2str(dimsize($ThisWave,1))+") "+ThisWave+"={"
		else			
			duplicate/t /o $ThisWave, TempWaveTxt
			data="make/o/t /n=("+num2str(dimsize($ThisWave,0))+","+num2str(dimsize($ThisWave,1))+") "+ThisWave+"={"
		endif	
		variable i,j
		if(dimsize($ThisWave,1)>0)
			for (j=0;j<dimsize($ThisWave,1);j+=1)
				data+="{"
				for (i=0;i<dimsize($ThisWave,0);i+=1)
					if(wavetype($ThisWave,1)==01)//numeric
						data+=num2str(TempWave[i][j])
					else
						data+="\""+TempWaveTxt[i][j]+"\""
					endif
					if(i<dimsize($ThisWave,0)-1)
						data+=","
					endif
				endfor	
				data+="},"	
			endfor
		else
			for (i=0;i<dimsize($ThisWave,0);i+=1)			
				if(wavetype($ThisWave,1)==01)//numeric
					data+=num2str(TempWave[i])+","
				else
					data+="\""+(TempWaveTxt[i])+"\","
				endif
			endfor	
		endif	
		data=removeending(data)+"}"
		print data
	endfor

	killwaves/z TempWave
	for (objects=0;objects<CountObjects("", 2 );objects+=1)
		execute "print \"variable/g "+GetIndexedObjName("", 2, objects )+"=\","+GetIndexedObjName("", 2, objects )
	endfor
	for (objects=0;objects<CountObjects("", 3 );objects+=1)
		execute "print \"string/g "+GetIndexedObjName("", 3, objects )+"=\","+GetIndexedObjName("", 3, objects )
	endfor	
end

function RecreateWaves()
  make/o /n=(6,3) color_blue={{256,2304,6144,8448,29440,42752},{256,6144,11776,16384,30208,45824},{13568,23296,31232,39424,47360,56064}}
  make/o /n=(6,3) color_blue_green={{0,0,256,0,30464,42240},{9472,16384,22784,28672,40704,49152},{11520,18688,25856,32256,43776,51968}}
  make/o /n=(6,3) color_blue_purple={{6144,12544,17664,22528,38656,50432},{0,6144,11520,16128,34816,47872},{15872,23552,30976,39168,49408,56576}}
  make/o /n=(6,3) color_green={{0,0,2048,0,32000,47872},{16384,24576,33024,41216,46336,54528},{4096,10752,14848,19200,34304,47616}}
  make/o /n=(6,3) color_orange={{24064,36096,48640,61952,63744,64768},{7936,14336,20224,25856,44288,52992},{0,512,6144,8704,31744,46336}}
  make/o /n=(6,3) color_purple={{11520,18688,25856,32512,43776,52992},{0,5632,11264,16128,36096,48896},{15616,22784,30976,38912,49408,56320}}
  make/o /n=(6,3) color_red={{23808,35328,47616,60672,62976,64256},{512,512,4864,7168,36608,50176},{256,1024,6656,9216,28672,44800}}
  make/o /n=(6,3) color_red_orange={{23040,35840,47616,61440,63488,64256},{3072,9472,15104,18688,39936,49920},{512,1024,6656,8960,30464,44032}}
  make/o /n=(6,3) color_red_purple={{17920,27648,36864,46848,52480,56320},{0,4096,8960,13312,36352,48128},{6656,13568,18944,24832,38912,48384}}
  make/o /n=(6,3) color_yellow={{25344,38144,51712,65280,65280,65280},{24576,35328,45824,56832,59392,63232},{20224,23552,21248,5888,34816,54784}}
  make/o /n=(6,3) color_yellow_green={{13312,22528,32000,40960,38912,54784},{18944,28160,37888,48128,49920,58368},{512,6912,11264,15104,36096,51712}}
  make/o /n=(6,3) color_yellow_orange={{24832,36864,49664,64000,64768,65280},{15616,24320,33536,42496,52224,65280},{0,0,4352,6656,35072,4787}}
  make/o /n=(4,0) color_selection_drawX={-0,-2.5981,2.5981,-0}
  make/o /n=(4,0) color_selection_drawY={3,-1.5,-1.5,3}
  make/o /n=(6,0) CWschemeX0={-0,-0,-0,-0,-0,-0}
  make/o /n=(6,0) CWschemeY0={6,5,4,3,2,1}
  make/o /n=(6,0) CWschemeX1={-3,-2.5,-2,-1.5,-1,-0.5}
  make/o /n=(6,0) CWschemeY1={5.1961,4.3301,3.4641,2.5981,1.732,0.86602}
  make/o /n=(6,0) CWschemeX2={-5.1962,-4.3301,-3.4641,-2.5981,-1.7321,-0.86603}
  make/o /n=(6,0) CWschemeY2={3,2.5,2,1.5,1,0.5}
  make/o /n=(6,0) CWschemeX3={-6,-5,-4,-3,-2,-1}
  make/o /n=(6,0) CWschemeY3={-2.2039e-05,-1.8366e-05,-1.4693e-05,-1.102e-05,-7.3464e-06,-3.6732e-06}
  make/o /n=(6,0) CWschemeX4={-5.1961,-4.3301,-3.4641,-2.5981,-1.732,-0.86602}
  make/o /n=(6,0) CWschemeY4={-3,-2.5,-2,-1.5,-1,-0.5}
  make/o /n=(6,0) CWschemeX5={-3,-2.5,-2,-1.5,-0.99999,-0.49999}
  make/o /n=(6,0) CWschemeY5={-5.1962,-4.3301,-3.4641,-2.5981,-1.7321,-0.86603}
  make/o /n=(6,0) CWschemeX6={4.4078e-05,3.6732e-05,2.9386e-05,2.2039e-05,1.4693e-05,7.3464e-06}
  make/o /n=(6,0) CWschemeY6={-6,-5,-4,-3,-2,-1}
  make/o /n=(6,0) CWschemeX7={3,2.5,2,1.5,1,0.50001}
  make/o /n=(6,0) CWschemeY7={-5.1961,-4.3301,-3.4641,-2.5981,-1.732,-0.86602}
  make/o /n=(6,0) CWschemeX8={5.1962,4.3302,3.4641,2.5981,1.7321,0.86603}
  make/o /n=(6,0) CWschemeY8={-2.9999,-2.5,-2,-1.5,-0.99998,-0.49999}
  make/o /n=(6,0) CWschemeX9={6,5,4,3,2,1}
  make/o /n=(6,0) CWschemeY9={6.6118e-05,5.5098e-05,4.4078e-05,3.3059e-05,2.2039e-05,1.102e-05}
  make/o /n=(6,0) CWschemeX10={5.1961,4.3301,3.4641,2.5981,1.732,0.86602}
  make/o /n=(6,0) CWschemeY10={3.0001,2.5001,2,1.5,1,0.50001}
  make/o /n=(6,0) CWschemeX11={2.9999,2.4999,2,1.5,0.99998,0.49999}
  make/o /n=(6,0) CWschemeY11={5.1962,4.3302,3.4641,2.5981,1.7321,0.86603}  
  make/o/n=(256,10) ColorTableShow=(q<5) ? p : -1
  make/o /n=(3,0) ColorTableLocX={5,5,5}
  make/o /n=(3,0) ColorTableLocation={0,50,100}
  make/o /n=(256,0) ColorTableScale=p
  make/o /n=(256,4) ColorTableMain=p
  make/o /n=(3) ColorTableMainB={5888,9216,39424}
  make/o /n=(3) ColorTableMainG={56832,7168,16384}
  make/o /n=(3) ColorTableMainR={65280,60672,8448}
  make/o /n=(3) ColorTableMainAlpha=65535
  make/o/n=(1000,3) ColorGrid=((q==0)*mod(p,10)+(q==1)*floor(p/10)+(q==2)*floor(p/100))*25.5	
  
  make/o/t /n=(12,0) color_wheel_names={"Yellow","Yellow_Orange","Orange","Red_Orange","Red","Red_Purple","Purple","Blue_Purple","Blue","Blue_Green","Green","Yellow_Green"}




  variable/g NumColors=  3
  variable/g ColorMain=  0
  variable/g ColorSepAxis1=  4
  variable/g ColorSepAxis2=  4
  variable/g ColorBrightness=  3
  variable/g Bright=  0
  string/g	CWname=""
 
end

