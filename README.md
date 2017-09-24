# GlorpDriverMySQL

Glorp Drive for MySql migrated from [ThomasHeniart][] and Update to work fine on Phar 6.0 and older.

## Instructions
  Build Chipmunk2D project, for Linux libs are in libs folder. Must put them in "Shared" folder inside pharo folder.
  
  -Open a Playground and evaluate:

```smalltalk
Metacello new
  baseline: 'GlorpDriverMySQL';
  repository: 'github://alvarop100/GlorpDriverMySQL
:master/source';
  load
```

[thomasheniart]: http://smalltalkhub.com/#!/~ThomasHeniart/GlorpDriverMySQL

