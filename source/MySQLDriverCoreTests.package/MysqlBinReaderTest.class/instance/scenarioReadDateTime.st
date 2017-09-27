Test Support
scenarioReadDateTime
'
Reading binary DATETIME
- should be a DateTime reading only <year>, <month> and <day> when <length> eq 4 bytes
- should be a DateTime also reading <hh>, <mm>, <ss> when <length> gt 4 bytes
- should be a DateTime also reading nanosecond part when <length> gt 7 bytes
'