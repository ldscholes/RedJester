SELECT COUNT(*) FROM google_form limit 1; 
SELECT COUNT(*) FROM google_form_update limit 1; 
INSERT INTO TABLE google_form
  SELECT * FROM google_form_update; 
SELECT COUNT(*) FROM google_form limit 1; 