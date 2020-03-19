#pragma rtGlobals=3		// Use modern global access method and strict wave access.

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

	setdatafolder $DF
	CalculateColorTable()
	selLocation=min(selLocation,numpnts(ColorTableLocation)-1)
	//ColorValList()
	PopupMenu ColorLocations mode=selLocation+1,win=GraphControlCW
	UpdateSelectedLocation(selLocation)
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
	SetDataFolder root:GraphControl:colorwheel:
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
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY0)={root:GraphControl::ColorWheel:color_yellow,*,*,directRGB},zColor(CWschemeY1)={root:GraphControl::ColorWheel:color_yellow_orange,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY2)={root:GraphControl::ColorWheel:color_orange,*,*,directRGB},zColor(CWschemeY3)={root:GraphControl::ColorWheel:color_red_orange,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY4)={root:GraphControl::ColorWheel:color_red,*,*,directRGB},zColor(CWschemeY5)={root:GraphControl::ColorWheel:color_red_purple,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY6)={root:GraphControl::ColorWheel:color_purple,*,*,directRGB},zColor(CWschemeY7)={root:GraphControl::ColorWheel:color_blue_purple,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY8)={root:GraphControl::ColorWheel:color_blue,*,*,directRGB},zColor(CWschemeY9)={root:GraphControl::ColorWheel:color_blue_green,*,*,directRGB}
	ModifyGraph/w=GraphControlCW#ColorWheelPlot zColor(CWschemeY10)={root:GraphControl::ColorWheel:color_green,*,*,directRGB},zColor(CWschemeY11)={root:GraphControl::ColorWheel:color_yellow_green,*,*,directRGB}
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

		string DF=getdatafolder(1)
		setdatafolder root:graphcontrol:ColorWheel
		wave colorTableMain
		setdatafolder root:graphcontrol:	
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
  
  make/o/t /n=(12,0) color_wheel_names={"Yellow","Yellow_Orange","Orange","Red_Orange","Red","Red_Purple","Purple","Blue_Purple","Blue","Blue_Green","Green","Yellow_Green"}




  variable/g NumColors=  3
  variable/g ColorMain=  0
  variable/g ColorSepAxis1=  4
  variable/g ColorSepAxis2=  4
  variable/g ColorBrightness=  3
  variable/g Bright=  0
  string/g	CWname=""
 
end

