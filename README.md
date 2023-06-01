# SOLMOVE
Move Charm/ITSM Documents from one Solution Manager 7.2 to another instance of Solution Manager. 
There will be a new document created, with a new number.

Following content will be moved:

    Soldoc links
    Custom fields (requieres mapping)
    Texts
    Business Partners (requieres mapping)
    Dates
    Cycles (requieres mapping)
    Ibase companents (requieres mapping)
    Approval procedure
    Links to other documents (CRM)
    Attachment
    Status
    Scope
    Transport
    Category data
    ?Base Data (crmd_orderadm_h)
    priority
    SLA

# Instalation
1) install abapgit
2) pull this repository in your systems (source and target)

# Utilisation
Run t-code SE38 program ZMOVE
