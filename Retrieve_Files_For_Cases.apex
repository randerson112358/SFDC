SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Case ) and LinkedEntity.Type='Case'
