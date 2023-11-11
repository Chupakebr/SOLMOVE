# Solution Manager Document Copy Tool

## Description
This program developed to:
- Move Charm/ITSM Documents from one Solution Manager 7.2 to another instance of Solution Manager.
- Copy of existing transactions within same Solution manager.
There will be a new document created with a new number in a target system.

## Following content will be moved:
```diff
+ Transaction types (requires mapping)
+ Description
+ Priority
+ Status (with status change history CRM_JCDS)
+ Attachments
+ Soldoc content
+ Cycles assingment (requieres mapping)
+ Ibase component (requieres mapping)
+ Custom fields from CUSTOMER_H (requires mapping)
+ Creation Information (Posting & Created Dates - Created by User)
+ Transport (with option to move CTS_ID on managed system)
+ Business Partners (requires mapping)
+ Reach Texts
+ Links to other documents (CRM)
+ Scope
+ SLA
+ Approval procedure
+ Multi-level category (With limitation that category ID are the same, requieres category move on a table level)
+ Log data (status, bp, priority and other change)
```
## Known limitations:
```diff
- Test managment data (test plans) not moved
- Not tested with Urgent transactions (they have there own task list)
- Cycles not moved and need to be created and mapped
- Custom fields created with AET, so far supports only fields created in CUSTOMER_H
- Move following tables to have same categorisation ID`s:
      CRMC_ERMS_CAT_OK
      CRMC_ERMS_CAT_SP
      CRMC_ERMS_CAT_LN
      CRMC_ERMS_CAT_AS
      CRMC_ERMS_CAT_AD
      CRMC_ERMS_CAT_HI
      CRMC_ERMS_CAT_CA
      CRMC_ERMS_CAT_CT
      CRMC_ERMS_CAT_CD
```

## Instalation
1) Install abapgit (https://abapgit.org/) in your source and target Solution manager
2) Pull this repository into your systems (source and target)
3) Create a trusted RFC destination from the source system to the target

## Utilisation
1)  Sorce system: In transaction, SM30 (table ZSOLMOVE_MAPPING), maintain mapping values for the fields which require mapping
2)  Sorce system: Run t-code SE38 program ZMOVE, with RFC destination to the target system (use "NONE" to create Documents in the same system)

## Mapping gidlines (table ZSOLMOVE_MAPPING)
```
Mapping example:
TYPE SUB_TYPE SOURCE TARGET
BP   877 265
CYCLE   8000003237 8000003238
FILD CUSTOMER_H ZZ_JIRA_ID ZZ_JIRA_ID
GUID CUSTOMER_H ZZAFLD00000B
ID CUSTOMER_H ZZAFLD000008
IBASE   7100000022 7100000022
ROOT   051Ml4Nz7kUsirt8NjCZwG 051Ml4Nz7kUsirt8NjCZwG
TYPE   S1BR S1BR
```
### Columns
```
TYPE     - ID of the mapped content
SUB_TYPE - sub table used for content (for AET created fields)
SOURCE   - Value in source system
TARGET   - Value in target system
```
Folowing id are mandatory: GUID, ID, TYPE

### Types
You need to identify 2 custom fields with AET to store old GUID and ID of the document for reference:
```
GUID  - AET created field to store legacy GUID (Table CUSTOMER_H) CHAR32
ID    - AET created field to store legacy ID (Table CUSTOMER_H)   CHAR10
```
```
TYPE  - Mapping of transaction types (i.e. Table CRMD_ORDERADM_H~PROCESS_TYPE)
BP    -  Business partner mapping (table but000~Partner)
CYCLE - Mapping of cycles id types (i.e. Table CRMD_ORDERADM_H~OBJECT_ID)
FILD  - Mapping between AET fields (so far only Table CUSTOMER_H is supported)
IBASE - Ibase mapping (COMM_PRODUCT~PRODUCT_ID)
ROOT  - Branch id`s mapping (Soldoc should be moved with standart Export/Import functionality) (SMUD_RNODE_T~ROOT_OCC)
```

## How to obtain support
This project is provided "as-is".

## License
Copyright (c) 2023 SAP SE or an SAP affiliate company. All rights reserved.
This file is licensed under the Apache Software License, v. 2 except as noted otherwise in the [LICENSE](https://github.com/Chupakebr/SOLMOVE/blob/main/License) file.

