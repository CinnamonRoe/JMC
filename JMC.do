cd "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\JMC project"

gen Sentiment = positive_NRC - negative_NRC
label var Sentiment "Sentiment Sum"

set scheme s1rcolor

*Overall
summarize Sentiment, detail
tab Sentiment
histogram Sentiment, discrete frequency
histogram Sentiment, discrete frequency fcolor(dknavy) lcolor(ltblue) xlabel(, grid glcolor(gs8)) ylabel(,grid format(%9.0g) angle(0) glcolor(gs8)) ytitle("Overall Frequency") yscale(lcolor(ltblue) lpattern(solid))
graph save "Graph" "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Overall Sentiment 2.gph"
graph export "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Overall Sentiment.jpg", as(jpg) name("Graph") quality(100)

*Christianity
summarize Sentiment if Christianity_gd >0, detail
tab Sentiment if Christianity_gd >0
histogram Sentiment if Christianity_gd >0, discrete frequency
histogram Sentiment if Christianity_gd >0, discrete frequency fcolor(dknavy) lcolor(ltblue) xlabel(, grid glcolor(gs8)) ylabel(,grid format(%9.0g) angle(0) glcolor(gs8)) ytitle("Christianity Frequency") yscale(lcolor(ltblue) lpattern(solid))
graph save "Graph" "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Christianity Sentiment 2.gph"
graph export "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Christianity Sentiment.jpg", as(jpg) name("Graph") quality(100)

*Islam
summarize Sentiment if Islam_gd >0, detail
tab Sentiment if Islam_gd >0
histogram Sentiment if Islam_gd >0, discrete frequency
histogram Sentiment if Islam_gd >0, discrete frequency fcolor(dknavy) lcolor(ltblue) xlabel(, grid glcolor(gs8)) ylabel(,grid format(%9.0g) angle(0) glcolor(gs8)) ytitle("Islam Frequency") yscale(lcolor(ltblue) lpattern(solid))
graph save "Graph" "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Islam Sentiment 2.gph"
graph export "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Islam Sentiment.jpg", as(jpg) name("Graph") quality(100)

*Judaism
summarize Sentiment if Judaism_gd >0, detail
tab Sentiment if Judaism_gd >0
histogram Sentiment if Judaism_gd >0, discrete frequency
histogram Sentiment if Judaism_gd >0, discrete frequency fcolor(dknavy) lcolor(ltblue) xlabel(, grid glcolor(gs8)) ylabel(,grid format(%9.0g) angle(0) glcolor(gs8)) ytitle("Judaism Frequency") yscale(lcolor(ltblue) lpattern(solid))
graph save "Graph" "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Judaism Sentiment 2.gph"
graph export "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Judaism Sentiment.jpg", as(jpg) name("Graph") quality(100)

*Religion
summarize Sentiment if Christianity_gd >0 | Islam_gd>0 | Judaism_gd>0 | Religion_gd>0, detail
tab Sentiment if Christianity_gd >0 | Islam_gd>0 | Judaism_gd>0 | Religion_gd>0
histogram Sentiment if Christianity_gd >0 | Islam_gd>0 | Judaism_gd>0 | Religion_gd>0, discrete frequency
histogram Sentiment if Christianity_gd >0 | Islam_gd>0 | Judaism_gd>0 | Religion_gd>0, discrete frequency fcolor(dknavy) lcolor(ltblue) xlabel(, grid glcolor(gs8)) ylabel(,grid format(%9.0g) angle(0) glcolor(gs8)) ytitle("Religion Frequency") yscale(lcolor(ltblue) lpattern(solid))
graph save "Graph" "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Religion Sentiment 2.gph"
graph export "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\Religion Sentiment.jpg", as(jpg) name("Graph") quality(100)

*No Religion
generate NoReligion = Christianity_gd + Islam_gd + Judaism_gd + Religion_gd
label var NoReligion "Religion Sum"
summarize NoReligion, detail
tab NoReligion
summarize Sentiment if NoReligion < 1, detail
tab Sentiment if NoReligion < 1
histogram Sentiment if NoReligion < 1, discrete frequency
histogram Sentiment if NoReligion < 1, discrete frequency fcolor(dknavy) lcolor(ltblue) xlabel(, grid glcolor(gs8)) ylabel(,grid format(%9.0g) angle(0) glcolor(gs8)) ytitle("No Religion Frequency") yscale(lcolor(ltblue) lpattern(solid))
graph save "Graph" "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\No Religion Sentiment 2.gph"
graph export "\\Client\C$\Users\Cinnamon_roe\Desktop\School\Spring 2024\NoReligion Sentiment.jpg", as(jpg) name("Graph") quality(100)

*Combine Graphs
graph combine "Christianity Sentiment" "Islam Sentiment" "Judaism Sentiment" "Overall Sentiment" "Religion Sentiment" "No Religion Sentiment"
graph combine "Christianity Sentiment 2" "Islam Sentiment 2" "Judaism Sentiment 2" "Overall Sentiment 2" "Religion Sentiment 2" "No Religion Sentiment 2"
graph combine "Christianity Graph Black" "Islam Graph Black" "Judaism Graph Black" "Overall Graph Black" "Religion Graph Black" "No Religion Graph Black"

*ttest presence of religion words
gen NoRels = 0 if NoReligion <1
replace NoRels = 1 if NoReligion >0
label var NoRels "Binary Religion"
ttest Sentiment, by(NoRels)

*ttest on presence of christianity words given religion words
gen ChristRels=0 if NoRels >0
replace ChristRels = 1 if Christianity_gd >0
label var ChristRels "Binary Christianity"
ttest Sentiment, by(ChristRels)

*ttest on presence of islam words given religion words
gen IslamRels = 0 if NoRels >0
replace IslamRels = 1 if Islam_gd >0
label var IslamRels "Binary Islam"
ttest Sentiment, by(IslamRels)

*ttest islam tweets and all other tweets
gen RelsIslam = 0
replace RelsIslam = 1 if Islam_gd >0
ttest Sentiment, by(RelsIslam)