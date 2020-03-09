#pragma rtGlobals=3		// Use modern global access method and strict wave access.

//Function to create the color wheel panel
Macro ColorWheelPlot()
	string DF=getdatafolder(1)
	dowindow /f ColorWheelPanel
	if(v_flag==0)
		newdatafolder/o/s root:colorwheel		 
		RecreateWaves()
		execute "ColorWheelPanel()"		
	endif
	setdatafolder $DF
end

//update of the controls on the CW panel
Function updateCWcontrols()
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:
	nvar NumColors,ColorMain,ColorSepAxis1,ColorSepAxis2,ColorBrightness	
	SetVariable AxisColor1,disable=(NumColors==1),win=ColorWheelPanel
	variable i
	for(i=1;i<=6;i+=1)
		PopupMenu $"ColorResult"+num2str(i) ,disable=1-(i<NumColors+1),win=ColorWheelPanel
		SetVariable $"ColorR"+num2str(i) noedit=0,disable=1-(i<NumColors+1),win=ColorWheelPanel
		SetVariable $"ColorG"+num2str(i) noedit=0,disable=1-(i<NumColors+1),win=ColorWheelPanel
		SetVariable $"ColorB"+num2str(i) noedit=0,disable=1-(i<NumColors+1),win=ColorWheelPanel
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
		SetVariable AxisColor1,limits={1,5,1},win=ColorWheelPanel

	endif
	if(NumColors==4)	//rectangle
		ColorSepAxis2=6-ColorSepAxis1
		SetVariable AxisColor1,limits={1,4,1},win=ColorWheelPanel
	endif	
	if(NumColors==6)	//heaxagon, 2 positions
		ColorSepAxis2=4-ColorSepAxis1
		SetVariable AxisColor1,limits={1,3,1},win=ColorWheelPanel
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
	wave/t  color_wheel_names
	make/o/n=3 col
	variable	location12=mod(location,12)
	location12+=(location12<0)*12
	controlinfo/w=ColorWheelPanel ColortableTypeTable
	if(v_value)	//---igor color table
		controlinfo/w=ColorWheelPanel ColorTableMenu 
		colorTab2Wave $S_Value
		wave M_colors
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
	return col
end

//draws the color selection
function drawCWshape()
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:
	wave/t color_wheel_names
	nvar NumColors,ColorMain,ColorSepAxis1,ColorSepAxis2,ColorBrightness	,tableupdate
	make/o/n=(NumColors+1) color_selection_drawX,color_selection_drawY
	variable location=ColorMain,i,location12,col,br
	for(i=0;i<NumColors;i+=1)		
		color_selection_drawX[i]=-(6-ColorBrightness)*sin(location/6*PI)
		color_selection_drawY[i]=(6-ColorBrightness)*cos(location/6*PI)
		PopupMenu $"ColorResult"+num2str(i+1) popColor=(CWcol(location,ColorBrightness)[0],CWcol(location,ColorBrightness)[1],CWcol(location,ColorBrightness)[2]),win=ColorWheelPanel
		SetVariable $"ColorR"+num2str(i+1) value=_NUM:CWcol(location,ColorBrightness)[0],win=ColorWheelPanel
		SetVariable $"ColorG"+num2str(i+1) value=_NUM:CWcol(location,ColorBrightness)[1],win=ColorWheelPanel
		SetVariable $"ColorB"+num2str(i+1) value=_NUM:CWcol(location,ColorBrightness)[2],win=ColorWheelPanel

		location+=mod(i+1,2)*ColorSepAxis1+mod(i,2)*ColorSepAxis2
	endfor
	color_selection_drawX[NumColors]=color_selection_drawX[0]
	color_selection_drawY[NumColors]=color_selection_drawY[0]
	//ModifyGraph marker(color_selection_drawY[0])=1
	//ModifyGraph/w=ColorWheelPanel#ColorWheelPlot 
	for(col=0;col<12;col++)
		make/o/n=(6,3) color_z
		for(br=0;br<6;br++)
			color_z[br][]=CWcol(col,br)[q]
		endfor
		duplicate/o color_z,$"color_z"+num2str(col)
		ModifyGraph/w=ColorWheelPanel#ColorWheelPlot zColor($"CWschemeY"+num2str(col))={$"color_z"+num2str(col),*,*,directRGB}

	endfor	
	setdatafolder $DF
	if(tableupdate)
		CopyToTable()
	endif
end

//shows the control of selected nodes
Function DisplayIndividualColors(ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum
	String varStr
	String varName
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:
	
	//---update the popup window
	controlinfo/w=ColorWheelPanel ColorTableR
	variable r=v_value
	controlinfo/w=ColorWheelPanel ColorTableG
	variable g=v_value
	controlinfo/w=ColorWheelPanel ColorTableB
	variable b=v_value
	controlinfo/w=ColorWheelPanel ColorTableALPHA
	variable alpha=v_value		
	PopupMenu ColorLocationPM popColor=(r,g,b,alpha),win=ColorWheelPanel
	wave ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR	,ColorTableMainAlpha
	controlinfo /w =ColorWheelPanel ColorLocations
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
	setdatafolder root:colorwheel:
	nvar minscale,maxscale
	wave  ColorTableMain,ColorTableLocation
	controlinfo /w=ColorWheelPanel  ColorTableSlider1
	variable pos=min(v_value,100)
	if(recalculate)
		controlinfo /w =ColorWheelPanel ColorLocations
		variable selLocation=v_value-1,okchange=1			
		if(selLocation>0)
			ColorTableLocation[selLocation]=max(ColorTableLocation[selLocation-1]+1,ColorTableLocation[selLocation])
		endif
		if(selLocation<numpnts(ColorTableLocation)-1)
			ColorTableLocation[selLocation]=min(ColorTableLocation[selLocation+1]-1,ColorTableLocation[selLocation])
		endif
		ColorTableLocation[selLocation]=pos*(maxscale-minscale)/100+minscale
		CalculateColorTable()
		UpdateSelectedLocation(selLocation)
	endif	
	//print pos
	Slider ColorTableSlider1 labelBack=(ColorTableMain[pos][0],ColorTableMain[pos][1],ColorTableMain[pos][2],ColorTableMain[pos][3]),win=ColorWheelPanel
	SetVariable ColorTableR value= _NUM:floor(ColorTableMain[pos][0]),win=ColorWheelPanel
	SetVariable ColorTableG value= _NUM:floor(ColorTableMain[pos][01]),win=ColorWheelPanel
	SetVariable ColorTableB value= _NUM:floor(ColorTableMain[pos][02]),win=ColorWheelPanel
	SetVariable ColorTableALPHA value= _NUM:floor(ColorTableMain[pos][03]),win=ColorWheelPanel
	PopupMenu ColorLocationPM popColor=(ColorTableMain[pos][0],ColorTableMain[pos][1],ColorTableMain[pos][2],ColorTableMain[pos][3]),win=ColorWheelPanel
	setdatafolder $DF
end




Function CopyToTable1()
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:
	
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
	Slider ColorTableSlider1 limits={0,TotalColors-2,1},win=ColorWheelPanel 
	make/o/n=(TotalColors,4) ColorTableMain=65535
	make/o/n=(TotalColors,10) ColorTableShow=p
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
	setdatafolder root:colorwheel:	
	nvar NumColors,ColorMain,ColorSepAxis1,ColorSepAxis2,ColorBrightness,Bright,minscale,maxscale
	variable location=ColorMain,i,br
	variable BrStops,TotalColors=NumColors,DkStops,BetweenStopValue=0
	Slider ColorTableSlider1 limits={0,101,1},win=ColorWheelPanel 
	controlinfo/w=ColorWheelPanel ColortableBright
	BrStops=v_value
	if(BrStops)
		BetweenStopValue=5
	endif
	controlinfo/w=ColorWheelPanel ColortableDark
	DkStops=v_value	
	TotalColors+=(DkStops||BrStops)*(NumColors*2-2)

	make/o/n=(TotalColors) ColorTableMainR,ColorTableMainG,ColorTableMainB,ColorTableMainAlpha,ColorTableLocation=p/(TotalColors-1)*(maxscale-minscale)+minscale
	make/o/n=(TotalColors,10) ColorTableShow=(q<5) ? p : -1

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
function LocationToPercent(input)
	variable input
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:	
	nvar minscale,maxscale	
	return (input-minscale)/(maxscale-minscale)*100
	setdatafolder $DF
end

//changes the scaling of the color tabel to 100 points
function/wave interpolateCT(NumPoints,ColorTableColor,ColorTableLocation)
	variable NumPoints
	wave ColorTableColor,ColorTableLocation
	variable i,pnt,startloc,endloc,loc
	make/o/n=(NumPoints) outputwave=ColorTableColor[numpnts(ColorTableLocation)-1]
	outputwave[0,LocationToPercent(ColorTableLocation[0])]=ColorTableColor[0]
	for (pnt=0;pnt<numpnts(ColorTableLocation)-1;pnt+=1)
		startloc=LocationToPercent(ColorTableLocation[pnt])
		endloc=min(LocationToPercent(ColorTableLocation[pnt+1]),NumPoints-1)
		for (loc=startloc;loc<endloc;loc+=1)
			outputwave[loc]=(loc-startloc)/(endloc-startloc)*(ColorTableColor[pnt+1]-ColorTableColor[pnt])+ColorTableColor[pnt]
		endfor
	endfor
	return outputwave
end

//changes the scaling of the color table to 100 points
function CalculateColorTable()
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:	
	nvar minscale,maxscale
	wave ColorTableMainR,ColorTableMainG,ColorTableMainB,ColorTableLocation,ColorTableMainAlpha
	make/o/n=(numpnts(ColorTableLocation)) ColorTableLocX=5
	make/o/n=101 CTMR,CTMG,CTMB,ColorTableScale
	
	make/o/n=(101,4) ColorTableMain
	make/o/n=(101,10) ColorTableShow=(q<5) ? p : -1
	SetScale/I x minscale,maxscale,"", ColorTableMain,ColorTableShow
	ColorTableScale=p*(maxscale-minscale)/numpnts(ColorTableScale)+minscale
	ColorTableLocation=max(min(ColorTableLocation,maxscale),minscale)
	sort ColorTableLocation,ColorTableLocation,ColorTableMainR,ColorTableMainG,ColorTableMainB,ColorTableMainAlpha
	duplicate/o  interpolateCT(101,ColorTableMainR,ColorTableLocation), CTMR
	duplicate/o  interpolateCT(101,ColorTableMainG,ColorTableLocation), CTMG
	duplicate/o  interpolateCT(101,ColorTableMainB,ColorTableLocation), CTMB
	duplicate/o  interpolateCT(101,ColorTableMainAlpha,ColorTableLocation), CTMALPHA
	ColorTableMain[][0]=CTMR[p]
	ColorTableMain[][1]=CTMG[p]
	ColorTableMain[][2]=CTMB[p]
	ColorTableMain[][3]=CTMALPHA[p]
	updateColorTableSlider(0)
	setdatafolder $DF
end

//helper function
Function/S ColorValList()
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:
	//nvar NumColors
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
	setdatafolder root:colorwheel:
	nvar NumColors
	wave ColorTableLocation	,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	Slider ColorTableSlider1 value= LocationToPercent(ColorTableLocation[selLocation]),win=ColorWheelPanel
	updateColorTableSlider(0)
	SetVariable ColorLocationSV value= _NUM:ColorTableLocation[selLocation],win=ColorWheelPanel
	PopupMenu ColorLocationPM popColor=(ColorTableMainR[selLocation],ColorTableMainG[selLocation],ColorTableMainB[selLocation],ColorTableMainAlpha[selLocation]),win=ColorWheelPanel
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
	setdatafolder root:colorwheel:
	nvar NumColors,maxscale,minscale
	wave ColorTableLocation
	controlinfo /w =ColorWheelPanel ColorLocations
	selLocation=v_value-1
	ColorTableLocation[selLocation]=varnum
	ColorTableLocation=max(min(ColorTableLocation,maxscale),minscale)

	Slider ColorTableSlider1 value= LocationToPercent(ColorTableLocation[selLocation]),win=ColorWheelPanel
	updateColorTableSlider(1)	
	setdatafolder $DF
End

Function SelectColorLocationPM(ctrlName,popNum,popStr) : PopupMenuControl
	String ctrlName
	Variable popNum
	String popStr
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:
	nvar NumColors
	wave ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR	,ColorTableMainAlpha
	controlinfo /w =ColorWheelPanel ColorLocations
	variable selLocation=v_value-1
	controlinfo /w =ColorWheelPanel ColorLocationPM
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
	setdatafolder root:colorwheel:
	nvar minscale,maxscale
	wave ColorTableLocation
	ColorTableLocation=max(min(ColorTableLocation,maxscale),minscale)
	setdatafolder $DF
	CalculateColorTable()
	UpdateSelectedLocation(0)
End

//update color table as colors change
Function UpdateColorTable(ctrlName,checked) : CheckBoxControl
	String ctrlName
	Variable checked	
	if(stringmatch(ctrlName,"*Type*"))
		CheckBox ColortableTypeColorWheel,value=0,win=ColorWheelPanel
		CheckBox ColortableTypeTable,value=0,win=ColorWheelPanel
	else
		CheckBox Colortableprimary,value=0,win=ColorWheelPanel
		CheckBox ColortableBright,value=0,win=ColorWheelPanel
		CheckBox ColortableDark,value=0,win=ColorWheelPanel
	endif
	CheckBox $ctrlName,value=1,win=ColorWheelPanel
	//CalculateColorTable()
	drawCWshape()
	//CopyToTable()
End

Function CopyToTableBTN(ctrlName) : ButtonControl
	String ctrlName
	CopyToTable()
	PopupMenu ColorLocations mode=1,win=ColorWheelPanel
	UpdateSelectedLocation(0)
End

//the slider directs the nodes
Function ColorTableSlider(ctrlName,sliderValue,event) : SliderControl
	String ctrlName
	Variable sliderValue
	Variable event	// bit field: bit 0: value set, 1: mouse down, 2: mouse up, 3: mouse moved
	if(event %& 0x1)	// bit 0, value set
		updateColorTableSlider(1)
	endif
	return 0
End

//increase the number of stop points
Function AddStop(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:
	wave ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	controlinfo /w =ColorWheelPanel ColorLocations
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
	controlinfo/w=ColorWheelPanel NumGradient
	variable selGradientNum=v_value
	setdatafolder root:colorwheel:
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
	controlinfo/w=ColorWheelPanel NumGradient
	variable selGradientNum=v_value
	setdatafolder root:colorwheel:
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
	setdatafolder root:colorwheel:
	wave ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	controlinfo /w =ColorWheelPanel ColorLocations
	variable selLocation=v_value-1
	if(numpnts(ColorTableLocation)>2)//can delete a point
		deletepoints selLocation,1,ColorTableLocation,ColorTableMainB,ColorTableMainG,ColorTableMainR,ColorTableMainAlpha
	endif

	setdatafolder $DF
	CalculateColorTable()
	selLocation=min(selLocation,numpnts(ColorTableLocation)-1)
	//ColorValList()
	PopupMenu ColorLocations mode=selLocation+1,win=ColorWheelPanel
	UpdateSelectedLocation(selLocation)
End

Function Export(ctrlName) : ButtonControl
	String ctrlName
	string DF=getdatafolder(1)
	setdatafolder root:colorwheel:
	wave ColorTableMain	
	svar CWname
	setdatafolder $DF
	controlinfo/w=ColorWheelPanel NumPoints
	variable ratio=dimsize(ColorTableMain,0)/v_value
	make/o/n=(v_value,4) $CWname=ColorTableMain[p*ratio][q]
	//duplicate/o ColorTableMain,$CWname
End


Window ColorWheelPanel() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(143,112,609,509)
	ShowTools/A
	GroupBox IndividualColorsGB,pos={166,2},size={290,100},title="Individual Colors"
	SetVariable NumColors,pos={171,20},size={100,16},proc=DisplayIndividualColors,title="# Colors"
	SetVariable NumColors,limits={1,6,1},value= root:ColorWheel:NumColors
	SetVariable FirstColor,pos={171,40},size={100,16},proc=DisplayIndividualColors,title="First Color"
	SetVariable FirstColor,limits={-1,12,1},value= root:ColorWheel:ColorMain
	SetVariable AxisColor1,pos={171,80},size={100,16},proc=DisplayIndividualColors,title="Separation"
	SetVariable AxisColor1,limits={1,5,1},value= root:ColorWheel:ColorSepAxis1
	SetVariable Brightness,pos={171,60},size={100,16},proc=DisplayIndividualColors,title="Brightness"
	SetVariable Brightness,limits={0,5,1},value= root:ColorWheel:ColorBrightness
	PopupMenu ColorResult1,pos={279,17},size={50,21}
	PopupMenu ColorResult1,mode=1,popColor= (65280,56832,5888),value= #"\"*COLORPOP*\""
	PopupMenu ColorResult2,pos={279,37},size={50,21}
	PopupMenu ColorResult2,mode=1,popColor= (60672,7168,9216),value= #"\"*COLORPOP*\""
	PopupMenu ColorResult3,pos={279,57},size={50,21}
	PopupMenu ColorResult3,mode=1,popColor= (8448,16384,39424),value= #"\"*COLORPOP*\""
	PopupMenu ColorResult4,pos={279,77},size={50,21},disable=1
	PopupMenu ColorResult4,mode=1,popColor= (0,41216,19200),value= #"\"*COLORPOP*\""
	SetVariable ColorR1,pos={330,20},size={40,16},proc=DisplayIndividualColors
	SetVariable ColorR1,limits={0,inf,0},value= _NUM:65280
	SetVariable ColorG1,pos={370,20},size={40,16},proc=DisplayIndividualColors
	SetVariable ColorG1,limits={0,inf,0},value= _NUM:56832//,styledText= 1
	SetVariable ColorB1,pos={410,20},size={40,16},proc=DisplayIndividualColors
	SetVariable ColorB1,limits={0,inf,0},value= _NUM:5888//,styledText= 1
	SetVariable ColorR2,pos={330,40},size={40,16},proc=DisplayIndividualColors
	SetVariable ColorR2,limits={0,inf,0},value= _NUM:60672//,styledText= 1
	SetVariable ColorG2,pos={370,40},size={40,16},proc=DisplayIndividualColors
	SetVariable ColorG2,limits={0,inf,0},value= _NUM:7168//,styledText= 1
	SetVariable ColorB2,pos={410,40},size={40,16},proc=DisplayIndividualColors
	SetVariable ColorB2,limits={0,inf,0},value= _NUM:9216//,styledText= 1
	SetVariable ColorR3,pos={330,60},size={40,16},proc=DisplayIndividualColors
	SetVariable ColorR3,limits={0,inf,0},value= _NUM:8448//,styledText= 1
	SetVariable ColorG3,pos={370,60},size={40,16},proc=DisplayIndividualColors
	SetVariable ColorG3,limits={0,inf,0},value= _NUM:16384//,styledText= 1
	SetVariable ColorB3,pos={410,60},size={40,16},proc=DisplayIndividualColors
	SetVariable ColorB3,limits={0,inf,0},value= _NUM:39424//,styledText= 1
	SetVariable ColorR4,pos={330,80},size={40,16},disable=1,proc=DisplayIndividualColors
	SetVariable ColorR4,limits={0,inf,0},value= _NUM:0//,styledText= 1
	SetVariable ColorG4,pos={370,80},size={40,16},disable=1,proc=DisplayIndividualColors
	SetVariable ColorG4,limits={0,inf,0},value= _NUM:41216//,styledText= 1
	SetVariable ColorB4,pos={410,80},size={40,16},disable=1,proc=DisplayIndividualColors
	SetVariable ColorB4,limits={0,inf,0},value= _NUM:19200//,styledText= 1
	PopupMenu ColorResult5,pos={279,97},size={50,21},disable=1
	PopupMenu ColorResult5,mode=1,popColor= (60672,7168,9216),value= #"\"*COLORPOP*\""
	SetVariable ColorR5,pos={330,100},size={40,16},disable=1,proc=DisplayIndividualColors
	SetVariable ColorR5,limits={0,inf,0},value= _NUM:60672//,styledText= 1
	SetVariable ColorG5,pos={370,100},size={40,16},disable=1,proc=DisplayIndividualColors
	SetVariable ColorG5,limits={0,inf,0},value= _NUM:7168//,styledText= 1
	SetVariable ColorB5,pos={410,100},size={40,16},disable=1,proc=DisplayIndividualColors
	SetVariable ColorB5,limits={0,inf,0},value= _NUM:9216//,styledText= 1
	PopupMenu ColorResult6,pos={279,117},size={50,21},disable=1
	PopupMenu ColorResult6,mode=1,popColor= (25856,11264,30976),value= #"\"*COLORPOP*\""
	SetVariable ColorR6,pos={330,120},size={40,16},disable=1,proc=DisplayIndividualColors
	SetVariable ColorR6,limits={0,inf,0},value= _NUM:25856//,styledText= 1
	SetVariable ColorG6,pos={370,120},size={40,16},disable=1,proc=DisplayIndividualColors
	SetVariable ColorG6,limits={0,inf,0},value= _NUM:11264//,styledText= 1
	SetVariable ColorB6,pos={410,120},size={40,16},disable=1,proc=DisplayIndividualColors
	SetVariable ColorB6,limits={0,inf,0},value= _NUM:30976//,styledText= 1
	GroupBox ColorTables,pos={166,144},size={290,243},title="Color Table"
	Slider ColorTableSlider1,pos={208,269},size={220,19},proc=ColorTableSlider
	Slider ColorTableSlider1,labelBack=(65280,56832,5888)
	Slider ColorTableSlider1,limits={0,101,1},value= 0,side= 2,vert= 0,ticks= 0
	Button CopyToTable,pos={4,167},size={120,30},proc=CopyToTableBTN,title="Copy to Color Table"
	CheckBox ColortableBright,pos={20,252},size={97,14},proc=UpdateColorTable,title="Add Bright Stops"
	CheckBox ColortableBright,value= 0,mode=1
	CheckBox ColortableUpdate,pos={5,201},size={53,14},title="Update"
	CheckBox ColortableUpdate,variable= root:ColorWheel:tableupdate
	CheckBox ColortableTypeTable,pos={173.00,105.00},size={44.00,15.00},proc=UpdateColorTable,title="Table"
	CheckBox ColortableTypeTable,value= 0,mode=1
	PopupMenu ColorTableMenu,pos={250.00,105.00},size={206.00,19.00},proc=CWColorTabelPopMenuProc,title=" "
	PopupMenu ColorTableMenu,mode=49,value= #"\"*COLORTABLEPOP*\""
	CheckBox ColortableTypeColorWheel,pos={173.00,125.00},size={81.00,15.00},proc=UpdateColorTable,title="Color Wheel"
	CheckBox ColortableTypeColorWheel,value= 1,mode=1
	
	PopupMenu ColorLocations,pos={176,165},size={113,21},proc=ColorLocationSelect,title="Gradient Stop #"
	PopupMenu ColorLocations,mode=1,popvalue="1",value= #"ColorValList()"
	SetVariable ColorTableR,pos={175,215},size={60,16},proc=DisplayIndividualColors
	SetVariable ColorTableR,limits={0,65535,255},value= _NUM:65280//,styledText= 1
	SetVariable ColorTableG,pos={235,215},size={60,16},proc=DisplayIndividualColors
	SetVariable ColorTableG,limits={0,65535,255},value= _NUM:56832//,styledText= 1
	SetVariable ColorTableB,pos={295,215},size={60,16},proc=DisplayIndividualColors
	SetVariable ColorTableB,limits={0,65535,255},value= _NUM:5888//,styledText= 1
	SetVariable ColorTableAlpha,pos={365.00,215.00},size={80.00,18.00},proc=DisplayIndividualColors,title="α"
	SetVariable ColorTableAlpha,limits={0,65535,255},value= _NUM:65535

	SetVariable ColorLocationSV,pos={231,194},size={90,16},proc=ChangeCTLocation,title="Position"
	SetVariable ColorLocationSV,value= _NUM:0
	PopupMenu ColorLocationPM,pos={175,191},size={50,21},proc=SelectColorLocationPM
	PopupMenu ColorLocationPM,mode=1,popColor= (65280,56832,5888),value= #"\"*COLORPOP*\""
	SetVariable MinScale,pos={171,313},size={70,16},proc=ScaleChanged,title="Min:"
	SetVariable MinScale,value= root:ColorWheel:minscale
	SetVariable MaxScale,pos={380,313},size={70,16},proc=ScaleChanged,title="Max:"
	SetVariable MaxScale,value= root:ColorWheel:maxscale
	Button AddGradientStop,pos={367,164},size={32,32},proc=AddStop,title="Add"
	Button RemoveGradientStop,pos={407,164},size={32,32},proc=Delstop,title="Del"
	CheckBox Colortableprimary,pos={20,232},size={108,14},proc=UpdateColorTable,title="Primary Colors Only"
	CheckBox Colortableprimary,value= 1,mode=1
	CheckBox ColortableDark,pos={20,272},size={93,14},proc=UpdateColorTable,title="Add Dark Stops"
	CheckBox ColortableDark,value= 0,mode=1
	Button Export,pos={172,349},size={60,30},proc=Export,title="Export"
	SetVariable ColorTableName,pos={235,357},size={214,16},noproc,title="Name:"
	SetVariable ColorTableName,limits={0,inf,0},value= root:ColorWheel:CWname
	Button SaveGradient,pos={5.00,330.00},size={50.00,32.00},proc=SaveGradient,title="Save"
	SetVariable NumGradient,pos={10.00,310.00},size={100.00,18.00},title="Gradient #"
	SetVariable NumGradient,limits={1,inf,1},value= _NUM:1
	Button LoadGradient,pos={65.00,330.00},size={50.00,32.00},proc=LoadGradient,title="Load"

	SetVariable NumPoints,pos={250.00,335.00},size={150.00,18.00},proc=ScaleChanged,title="Number of points:"
	SetVariable NumPoints,format="%d",limits={1,inf,1},value= _NUM:100

	String fldrSav0= GetDataFolder(1)
	SetDataFolder root:ColorWheel:
	Display/W=(0,0,160,160)/HOST=#  CWschemeY0 vs CWschemeX0
	AppendToGraph CWschemeY1 vs CWschemeX1
	AppendToGraph CWschemeY2 vs CWschemeX2
	AppendToGraph CWschemeY3 vs CWschemeX3
	AppendToGraph CWschemeY4 vs CWschemeX4
	AppendToGraph CWschemeY5 vs CWschemeX5
	AppendToGraph CWschemeY6 vs CWschemeX6
	AppendToGraph CWschemeY7 vs CWschemeX7
	AppendToGraph CWschemeY8 vs CWschemeX8
	AppendToGraph CWschemeY9 vs CWschemeX9
	AppendToGraph CWschemeY10 vs CWschemeX10
	AppendToGraph CWschemeY11 vs CWschemeX11
	AppendToGraph color_selection_drawY vs color_selection_drawX
	SetDataFolder fldrSav0
	ModifyGraph margin(left)=20,margin(bottom)=20,margin(top)=20,margin(right)=20,width=120
	ModifyGraph height=120
	ModifyGraph mode=4
	ModifyGraph marker(CWschemeY0)=19,marker(CWschemeY1)=19,marker(CWschemeY2)=19,marker(CWschemeY3)=19
	ModifyGraph marker(CWschemeY4)=19,marker(CWschemeY5)=19,marker(CWschemeY6)=19,marker(CWschemeY7)=19
	ModifyGraph marker(CWschemeY8)=19,marker(CWschemeY9)=19,marker(CWschemeY10)=19,marker(CWschemeY11)=19
	ModifyGraph marker(color_selection_drawY)=41
	ModifyGraph lStyle(color_selection_drawY)=2
	ModifyGraph rgb(color_selection_drawY)=(65280,0,0)
	ModifyGraph msize(CWschemeY0)=4,msize(CWschemeY1)=4,msize(CWschemeY2)=4,msize(CWschemeY3)=4
	ModifyGraph msize(CWschemeY4)=4,msize(CWschemeY5)=4,msize(CWschemeY6)=4,msize(CWschemeY7)=4
	ModifyGraph msize(CWschemeY8)=4,msize(CWschemeY9)=4,msize(CWschemeY10)=4,msize(CWschemeY11)=4
	ModifyGraph msize(color_selection_drawY)=6
	ModifyGraph zColor(CWschemeY0)={:ColorWheel:color_yellow,*,*,directRGB},zColor(CWschemeY1)={:ColorWheel:color_yellow_orange,*,*,directRGB}
	ModifyGraph zColor(CWschemeY2)={:ColorWheel:color_orange,*,*,directRGB},zColor(CWschemeY3)={:ColorWheel:color_red_orange,*,*,directRGB}
	ModifyGraph zColor(CWschemeY4)={:ColorWheel:color_red,*,*,directRGB},zColor(CWschemeY5)={:ColorWheel:color_red_purple,*,*,directRGB}
	ModifyGraph zColor(CWschemeY6)={:ColorWheel:color_purple,*,*,directRGB},zColor(CWschemeY7)={:ColorWheel:color_blue_purple,*,*,directRGB}
	ModifyGraph zColor(CWschemeY8)={:ColorWheel:color_blue,*,*,directRGB},zColor(CWschemeY9)={:ColorWheel:color_blue_green,*,*,directRGB}
	ModifyGraph zColor(CWschemeY10)={:ColorWheel:color_green,*,*,directRGB},zColor(CWschemeY11)={:ColorWheel:color_yellow_green,*,*,directRGB}
	ModifyGraph marker(color_selection_drawY[0])=1
	ModifyGraph nticks=0
	ModifyGraph axThick=0
	RenameWindow #,ColorWheelPlot
	SetActiveSubwindow ##
	String fldrSav1= GetDataFolder(1)
	SetDataFolder root:ColorWheel:
	display/W=(207,289,427,304)/HOST=#  
	appendImage ColorTableShow
	AppendToGraph ColorTableLocX vs ColorTableLocation
	AppendToGraph ColorTableLocX vs ColorTableLocation
	SetDataFolder fldrSav1
	ModifyGraph margin(left)=10,margin(bottom)=-1,margin(top)=-1,margin(right)=10,width=200
	ModifyGraph height=15
	ModifyGraph mode(ColorTableLocX)=3,marker(ColorTableLocX)=23
	ModifyGraph mode(ColorTableLocX#1)=3,marker(ColorTableLocX#1)=10,msize(ColorTableLocX#1)=3,rgb(ColorTableLocX#1)=(65535,65535,65535)
	//ModifyGraph marker(ColorTableShow)=16
	//ModifyGraph lSize(ColorTableShow)=10
	ModifyGraph msize(ColorTableLocX)=5
	ModifyGraph useMrkStrokeRGB(ColorTableLocX)=1
	ModifyImage ColorTableShow cindex= :ColorWheel:ColorTableMain,minRGB=NaN,maxRGB=0
	
	//ModifyGraph zColor(ColorTableShow)={:ColorWheel:ColorTableScale,*,*,cindexRGB,0,:ColorWheel:ColorTableMain}
	ModifyGraph zColor(ColorTableLocX)={:ColorWheel:ColorTableLocation,*,*,cindexRGB,0,:ColorWheel:ColorTableMain}
	ModifyGraph nticks=0
	ModifyGraph axThick=0
	RenameWindow #,ColorTableScale
	SetActiveSubwindow ##
	 CopyToTableBTN("")
EndMacro

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
  make/o/n=(101,10) ColorTableShow=(q<5) ? p : -1
  make/o /n=(3,0) ColorTableLocX={5,5,5}
  make/o /n=(3,0) ColorTableLocation={0,50,100}
  make/o /n=(101,0) ColorTableScale=p
  make/o /n=(101,4) ColorTableMain=p
  make/o /n=(3) ColorTableMainB={5888,9216,39424}
  make/o /n=(3) ColorTableMainG={56832,7168,16384}
  make/o /n=(3) ColorTableMainR={65280,60672,8448}
  make/o /n=(3) ColorTableMainAlpha=65535
  
  make/o/t /n=(12,0) color_wheel_names={"Yellow","Yellow_Orange","Orange","Red_Orange","Red","Red_Purple","Purple","Blue_Purple","Blue","Blue_Green","Green","Yellow_Green"}




  variable/g NumColors=  3
  variable/g ColorMain=  0
  variable/g ColorSepAxis1=  4
  variable/g ColorSepAxis2=  4
  variable/g ColorBrightness=  3
  variable/g Bright=  0
  variable/g minscale=  0
  variable/g tableupdate=  0
  variable/g maxscale=  100
  string/g	CWname=""
 
end