SOURCE 'comments-table.cql';

// START-create
CREATE SEARCH INDEX ON cycling.comments 
   WITH COLUMNS record_id { excluded:true }, * {excluded:false};
// END-create

// **CHANGING the CONFIG**

// START-directoryFactory
ALTER SEARCH INDEX CONFIG ON cycling.comments 
   SET directoryFactory = 'encrypted';
// END-directoryFactory

// START-active
RELOAD SEARCH INDEX ON cycling.comments;
// END-active

// START-rebuild
RELOAD SEARCH INDEX ON cycling.comments;
REBUILD SEARCH INDEX ON cycling.comments;
// END-rebuild

// START-cache
ALTER SEARCH INDEX CONFIG ON cycling.comments 
   SET autoCommitTime = 10000;
// END-cache

// START-requesth
ALTER SEARCH INDEX CONFIG ON cycling.comments 
ADD requestHandler[@name='/elevate',@class='solr.SearchHandler', @startup='lazy'] 
WITH  $$ {"defaults":[{"echoParams":"explicit"}],"last-components":["elevator"]} $$;
// END-requesth

// Policy to merge large segements due to deletes
// START-delete
ALTER SEARCH INDEX CONFIG ON cycling.comments 
  SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].bool[@name='mergeSingleSegments'] = true;
ALTER SEARCH INDEX CONFIG ON cycling.comments 
  SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='maxMergedSegmentMB'] = 1005;
ALTER SEARCH INDEX CONFIG ON cycling.comments 
  SET indexConfig.mergePolicyFactory[@class='org.apache.solr.index.AutoExpungeDeletesTieredMergePolicyFactory'].int[@name='forceMergeDeletesPctAllowed'] = 25;
// END-delete

// START-commit
COMMIT SEARCH INDEX ON cycling.comments;
// END-commit

// **CHANGING the SCHEMA**

// START-add
ALTER SEARCH INDEX SCHEMA ON cycling.comments 
   ADD fields.field[@name='fieldname', @type='StrField', @multiValued = 'false', @indexed='true'];
// END-add

// START-column_name
ALTER SEARCH INDEX SCHEMA ON cycling.comments 
   ADD FIELD record_id;
// END-column_name

// START-rename
ALTER SEARCH INDEX SCHEMA ON cycling.comments 
   SET field[@name='fieldname']@name = 'anotherFieldName';
// END-rename

// START-type
ALTER SEARCH INDEX SCHEMA ON cycling.comments 
   SET field[@name='fieldname']@type = 'UUIDField';
// END-type

// START-drop
ALTER SEARCH INDEX SCHEMA ON cycling.comments 
  DROP field anotherFieldName;
// END-drop

// **CHANGING the CONFIG **
// START-autocommit
ALTER SEARCH INDEX CONFIG ON cycling.comments 
   SET autoCommitTime = 1000;
// END-autocommit