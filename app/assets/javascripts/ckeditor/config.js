CKEDITOR.editorConfig = function( config )
{
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';
    config.toolbar = 'Custom';

    config.toolbar_Custom =
    [
        { name: 'clipboard', items : ['Undo','Redo' ] },
        { name: 'basicstyles', items : [ 'Bold','Italic','RemoveFormat' ] },
        { name: 'paragraph', items : [ 'NumberedList','BulletedList'] },
        { name: 'links', items : [ 'Link','Unlink'] },
    ];
};