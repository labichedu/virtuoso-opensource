--
--  $Id$
--
--  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
--  project.
--
--  Copyright (C) 1998-2007 OpenLink Software
--
--  This project is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; only version 2 of the License, dated June 1991.
--
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
--  General Public License for more details.
--
--  You should have received a copy of the GNU General Public License along
--  with this program; if not, write to the Free Software Foundation, Inc.,
--  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
--

-- Tables
AB.WA.exec_no_error('DROP TABLE AB.WA.PERSONS');
AB.WA.exec_no_error('DROP TABLE AB.WA.LDAP_SERVERS');
AB.WA.exec_no_error('DROP TABLE AB.WA.TAGS');
AB.WA.exec_no_error('DROP TABLE AB.WA.SETTINGS');

-- Types
AB.WA.exec_no_error('delete from WA_TYPES where WAT_NAME = \'AddressBook\'');
AB.WA.exec_no_error('drop type wa_AddressBook');

-- Views
AB.WA.exec_no_error('drop view SN..TAGS_VIEW');

-- Registry
registry_remove ('ab_path');
registry_remove ('ab_version');
registry_remove ('ab_build_');
registry_remove ('ab_index_version');
registry_remove ('__ods_addressbook_sioc_init');

-- Procedures
create procedure AB.WA.drop_procedures()
{
  for (select P_NAME from DB.DBA.SYS_PROCEDURES where P_NAME like 'AB.WA.%') do {
    if (P_NAME not in ('AB.WA.exec_no_error', 'AB.WA.drop_procedures'))
      AB.WA.exec_no_error(sprintf('drop procedure %s', P_NAME));
  }
}
;

-- dropping procedures for AddressBook
AB.WA.drop_procedures();
AB.WA.exec_no_error('DROP procedure AB.WA.drop_procedures');

-- dropping SIOC procs
AB.WA.exec_no_error('DROP procedure SIOC.DBA.fill_ods_addressbook_sioc');
AB.WA.exec_no_error('DROP procedure SIOC.DBA.ods_addressbook_sioc_init');

-- final proc
AB.WA.exec_no_error('DROP procedure AB.WA.exec_no_error');
