INSERT IGNORE
INTO global_property
(property, property_value, description, uuid) values
('bahmni.appointments.runningOnOpenMRS', 'true', 'If set to true, the appointments ui will run independent of bahmni core', uuid
());
INSERT IGNORE
INTO global_property
(property, property_value, description, uuid) values
('bahmni.primaryIdentifierType', '05a29f94-c0ed-11e2-94be-8c13b969e334', 'Primary identifier type for looking up patients, generating barcodes, etc.', uuid
());
INSERT IGNORE
INTO privilege
(privilege, description, uuid) VALUES
('Manage Appointments', 'Able to manage Appointments in Appointments module', uuid
());
INSERT IGNORE
INTO privilege
(privilege, description, uuid) VALUES
('Manage Appointment Services', 'Able to manage Appointments in Appointments module', uuid
());
INSERT IGNORE
INTO privilege
(privilege, description, uuid) VALUES
('Manage Appointment Specialities', 'Able to manage Appointments in Appointments module', uuid
());
INSERT IGNORE
INTO role values
('Bahmni Role', 'Role for bahmni Appointments', uuid
());
INSERT IGNORE
INTO role_privilege values
('Bahmni Role', 'Manage Appointments');
INSERT IGNORE
INTO role_privilege values
('Bahmni Role', 'Manage Appointment Services');
INSERT IGNORE
INTO role_privilege values
('Bahmni Role', 'Manage Appointment Specialities');