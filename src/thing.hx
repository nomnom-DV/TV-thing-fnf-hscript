import flixel.util.FlxColor;
var shad:FlxRuntimeShader;
var STUFF:FlxSprite;
var tvContent:FlxSprite;
function onCreate(){
    shad = new FlxRuntimeShader("
    #pragma header
    vec2 uBlocksize = vec2(7, 7);
    uniform float size;

    void main()
    {
        // was taken from the mosaic effect but was edited to prevent blur
        if (size > 0) { // bigger than 640x360
            vec2 blocks = openfl_TextureSize / uBlocksize;
            gl_FragColor = texture2D(bitmap, floor(openfl_TextureCoordv * blocks) / blocks);

            if (size > 1) {// checking for dumbas, must be > 1280x720 
                vec2 offset = vec2(0, 0);
                if (gl_FragColor == texture2D(bitmap, (floor(openfl_TextureCoordv * blocks) + offset - vec2(0.25, 0)) / blocks)) {
                    offset += vec2(0.25, 0);
                }
                // if (gl_FragColor == texture2D(bitmap, (floor(openfl_TextureCoordv * blocks) + offset - vec2(0, 0.25)) / blocks)) {
                //     offset += vec2(0, 0.25);
                // }
                gl_FragColor = texture2D(bitmap, (floor(openfl_TextureCoordv * blocks) + offset) / blocks).brga;
            }
        } else
            gl_FragColor = texture2D(bitmap, openfl_TextureCoordv).brga;

     }
    ");
    shad.setFloat("size",30.0);
    tvContent = new FlxSprite();
    tvContent.makeGraphic(1280, 720, FlxColor.BLACK);
    game.addBehindDad(tvContent);
    tvContent.screenCenter();
    tvContent.shader = shad;
    tvContent.scale.set(0.5,0.5);
    //tvContent.colorTransform.redOffset = tvContent.colorTransform.blueOffset = tvContent.colorTransform.greenOffset = 100;
    tvContent.x+=110;
    trace("gyatt!");
}
function onUpdatePost(elapsed:Float){
    tvContent.pixels.draw(game.camGame._scrollRect);
}