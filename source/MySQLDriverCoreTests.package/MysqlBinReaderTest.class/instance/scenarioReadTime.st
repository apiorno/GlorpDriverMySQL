Test Support
scenarioReadTime
'
Reading binary TIME
- should be a negative Duration when <sign> is non-zero
- should be a Duration when only <days> field present
- should be a Duration when <days> gt 0
- should be a Time set to zero hour when <length> is 0
- should be a Time when <sign> is positive and <days> eq 0
- should read the <days> part when supplied
- should read the <hh>:<mm>:<ss> part when supplied
- should read the <subseconds> part when supplied
'