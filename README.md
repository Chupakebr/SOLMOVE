# SOLMOVE
Move Charm/ITSM Documents from one Solution Manager 7.2 to another instance of Solution Manager. 
There will be a new document created with a new number.

The following content will be moved:
```diff
+ Transaction types (requires mapping)
+ Description
+ Priority
! Status (include inactive)
+ Attachments
+ Soldoc content
+ Cycles (requieres mapping)
+ Ibase component (requieres mapping)
+ Custom fields from CUSTOMER_H (requires mapping)
+ Creation Information (Posting & Created Dates - Created by User)

- SLA
- Approval procedure
- Links to other documents (CRM)
- Scope
! Transport

- Status change history (CRM_JCDS)
! Multi-level category (requires mapping)
- Reach Texts
! Business Partners (requires mapping)
```

# Instalation
1) Install abapgit (https://abapgit.org/) in your source and target Solution manager
2) Pull this repository into your systems (source and target)
3) Create a trusted RFC destination from the source system to the target

# Utilisation
1)  Sorce system: In transaction, SM30 (table ZSOLMOVE_MAPPING), maintain mapping values for the fields which require mapping
2)  Sorce system: Run t-code SE38 program ZMOVE, with RFC destination to the target system 
