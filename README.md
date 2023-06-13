# SOLMOVE
Move Charm/ITSM Documents from one Solution Manager 7.2 to another instance of Solution Manager. 
There will be a new document created, with a new number.

Following content will be moved:
```diff
+ Transaction types (requieres mapping)
+ Description
+ Priority
+ Status
- Texts (requieres mapping)
- Soldoc content
- Custom fields (requieres mapping)
- Business Partners (requieres mapping)
- Dates
- Cycles (requieres mapping)
- Ibase companents (requieres mapping)
- Approval procedure
- Links to other documents (CRM)
- Attachment
- Scope
- Transport
- Category data
- SLA
? Base Data (crmd_orderadm_h)
```

# Instalation
1) Install abapgit (https://abapgit.org/) in your sorce and target Solution manager
2) Pull this repository in to your systems (source and target)
3) Create trusted RFC destanation from source system to the target

# Utilisation
1)  Sorce system: In trunsaction SM30 (table ZSOLMOVE_MAPPING) maintain mapping values for the fields which requieres mapping
2)  Sorce system: Run t-code SE38 program ZMOVE, with RFC destanation to the target system 
