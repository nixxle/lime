package lime._backend.native;


import lime.graphics.opengl.GLQuery;
import lime.graphics.opengl.GLSampler;
import lime.graphics.opengl.GLSync;
import lime.graphics.opengl.GLTransformFeedback;
import lime.graphics.opengl.GLVertexArrayObject;
import lime.graphics.opengl.ext.*;
import lime.graphics.opengl.GLActiveInfo;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLContextAttributes;
import lime.graphics.opengl.GLContextType;
import lime.graphics.opengl.GLFramebuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLRenderbuffer;
import lime.graphics.opengl.GLShader;
import lime.graphics.opengl.GLShaderPrecisionFormat;
import lime.graphics.opengl.GLTexture;
import lime.graphics.opengl.GLUniformLocation;
import lime.graphics.opengl.GL;
import lime.system.System;
import lime.utils.ArrayBuffer;
import lime.utils.ArrayBufferView;
import lime.utils.DataPointer;
import lime.utils.Float32Array;
import lime.utils.Int32Array;


#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end

@:allow(lime.ui.Window)
@:access(lime._backend.native.NativeCFFI)
@:access(lime.graphics.opengl)


class NativeGLRenderContext {
	
	
	private static var __extensionObjects:Map<String, Dynamic>;
	private static var __extensionObjectTypes = new Map<String, Class<Dynamic>> ();
	private static var __lastContextID = 0;
	private static var __supportedExtensions:Array<String>;
	
	public var DEPTH_BUFFER_BIT = 0x00000100;
	public var STENCIL_BUFFER_BIT = 0x00000400;
	public var COLOR_BUFFER_BIT = 0x00004000;
	
	public var POINTS = 0x0000;
	public var LINES = 0x0001;
	public var LINE_LOOP = 0x0002;
	public var LINE_STRIP = 0x0003;
	public var TRIANGLES = 0x0004;
	public var TRIANGLE_STRIP = 0x0005;
	public var TRIANGLE_FAN = 0x0006;
	
	public var ZERO = 0;
	public var ONE = 1;
	public var SRC_COLOR = 0x0300;
	public var ONE_MINUS_SRC_COLOR = 0x0301;
	public var SRC_ALPHA = 0x0302;
	public var ONE_MINUS_SRC_ALPHA = 0x0303;
	public var DST_ALPHA = 0x0304;
	public var ONE_MINUS_DST_ALPHA = 0x0305;
	
	public var DST_COLOR = 0x0306;
	public var ONE_MINUS_DST_COLOR = 0x0307;
	public var SRC_ALPHA_SATURATE = 0x0308;
	
	public var FUNC_ADD = 0x8006;
	public var BLEND_EQUATION = 0x8009;
	public var BLEND_EQUATION_RGB = 0x8009;
	public var BLEND_EQUATION_ALPHA = 0x883D;
	
	public var FUNC_SUBTRACT = 0x800A;
	public var FUNC_REVERSE_SUBTRACT = 0x800B;
	
	public var BLEND_DST_RGB = 0x80C8;
	public var BLEND_SRC_RGB = 0x80C9;
	public var BLEND_DST_ALPHA = 0x80CA;
	public var BLEND_SRC_ALPHA = 0x80CB;
	public var CONSTANT_COLOR = 0x8001;
	public var ONE_MINUS_CONSTANT_COLOR = 0x8002;
	public var CONSTANT_ALPHA = 0x8003;
	public var ONE_MINUS_CONSTANT_ALPHA = 0x8004;
	public var BLEND_COLOR = 0x8005;
	
	public var ARRAY_BUFFER = 0x8892;
	public var ELEMENT_ARRAY_BUFFER = 0x8893;
	public var ARRAY_BUFFER_BINDING = 0x8894;
	public var ELEMENT_ARRAY_BUFFER_BINDING = 0x8895;
	
	public var STREAM_DRAW = 0x88E0;
	public var STATIC_DRAW = 0x88E4;
	public var DYNAMIC_DRAW = 0x88E8;
	
	public var BUFFER_SIZE = 0x8764;
	public var BUFFER_USAGE = 0x8765;
	
	public var CURRENT_VERTEX_ATTRIB = 0x8626;
	
	public var FRONT = 0x0404;
	public var BACK = 0x0405;
	public var FRONT_AND_BACK = 0x0408;
	
	public var TEXTURE_2D = 0x0DE1;
	
	public var CULL_FACE = 0x0B44;
	public var BLEND = 0x0BE2;
	public var DITHER = 0x0BD0;
	public var STENCIL_TEST = 0x0B90;
	public var DEPTH_TEST = 0x0B71;
	public var SCISSOR_TEST = 0x0C11;
	public var POLYGON_OFFSET_FILL = 0x8037;
	public var SAMPLE_ALPHA_TO_COVERAGE = 0x809E;
	public var SAMPLE_COVERAGE = 0x80A0;
	
	public var NO_ERROR = 0;
	public var INVALID_ENUM = 0x0500;
	public var INVALID_VALUE = 0x0501;
	public var INVALID_OPERATION = 0x0502;
	public var OUT_OF_MEMORY = 0x0505;
	
	public var CW  = 0x0900;
	public var CCW = 0x0901;
	
	public var LINE_WIDTH = 0x0B21;
	public var ALIASED_POINT_SIZE_RANGE = 0x846D;
	public var ALIASED_LINE_WIDTH_RANGE = 0x846E;
	public var CULL_FACE_MODE = 0x0B45;
	public var FRONT_FACE = 0x0B46;
	public var DEPTH_RANGE = 0x0B70;
	public var DEPTH_WRITEMASK = 0x0B72;
	public var DEPTH_CLEAR_VALUE = 0x0B73;
	public var DEPTH_FUNC = 0x0B74;
	public var STENCIL_CLEAR_VALUE = 0x0B91;
	public var STENCIL_FUNC = 0x0B92;
	public var STENCIL_FAIL = 0x0B94;
	public var STENCIL_PASS_DEPTH_FAIL = 0x0B95;
	public var STENCIL_PASS_DEPTH_PASS = 0x0B96;
	public var STENCIL_REF = 0x0B97;
	public var STENCIL_VALUE_MASK = 0x0B93;
	public var STENCIL_WRITEMASK = 0x0B98;
	public var STENCIL_BACK_FUNC = 0x8800;
	public var STENCIL_BACK_FAIL = 0x8801;
	public var STENCIL_BACK_PASS_DEPTH_FAIL = 0x8802;
	public var STENCIL_BACK_PASS_DEPTH_PASS = 0x8803;
	public var STENCIL_BACK_REF = 0x8CA3;
	public var STENCIL_BACK_VALUE_MASK = 0x8CA4;
	public var STENCIL_BACK_WRITEMASK = 0x8CA5;
	public var VIEWPORT = 0x0BA2;
	public var SCISSOR_BOX = 0x0C10;
	
	public var COLOR_CLEAR_VALUE = 0x0C22;
	public var COLOR_WRITEMASK = 0x0C23;
	public var UNPACK_ALIGNMENT = 0x0CF5;
	public var PACK_ALIGNMENT = 0x0D05;
	public var MAX_TEXTURE_SIZE = 0x0D33;
	public var MAX_VIEWPORT_DIMS = 0x0D3A;
	public var SUBPIXEL_BITS = 0x0D50;
	public var RED_BITS = 0x0D52;
	public var GREEN_BITS = 0x0D53;
	public var BLUE_BITS = 0x0D54;
	public var ALPHA_BITS = 0x0D55;
	public var DEPTH_BITS = 0x0D56;
	public var STENCIL_BITS = 0x0D57;
	public var POLYGON_OFFSET_UNITS = 0x2A00;
	
	public var POLYGON_OFFSET_FACTOR = 0x8038;
	public var TEXTURE_BINDING_2D = 0x8069;
	public var SAMPLE_BUFFERS = 0x80A8;
	public var SAMPLES = 0x80A9;
	public var SAMPLE_COVERAGE_VALUE = 0x80AA;
	public var SAMPLE_COVERAGE_INVERT = 0x80AB;
	
	public var NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2;
	public var COMPRESSED_TEXTURE_FORMATS = 0x86A3;
	
	public var DONT_CARE = 0x1100;
	public var FASTEST = 0x1101;
	public var NICEST = 0x1102;
	
	public var GENERATE_MIPMAP_HINT = 0x8192;
	
	public var BYTE = 0x1400;
	public var UNSIGNED_BYTE = 0x1401;
	public var SHORT = 0x1402;
	public var UNSIGNED_SHORT = 0x1403;
	public var INT = 0x1404;
	public var UNSIGNED_INT = 0x1405;
	public var FLOAT = 0x1406;
	public var FIXED = 0x0140C;
	
	public var DEPTH_COMPONENT = 0x1902;
	public var ALPHA = 0x1906;
	public var RGB = 0x1907;
	public var RGBA = 0x1908;
	public var LUMINANCE = 0x1909;
	public var LUMINANCE_ALPHA = 0x190A;
	
	public var UNSIGNED_SHORT_4_4_4_4 = 0x8033;
	public var UNSIGNED_SHORT_5_5_5_1 = 0x8034;
	public var UNSIGNED_SHORT_5_6_5 = 0x8363;
	
	public var FRAGMENT_SHADER = 0x8B30;
	public var VERTEX_SHADER = 0x8B31;
	public var MAX_VERTEX_ATTRIBS = 0x8869;
	public var MAX_VERTEX_UNIFORM_VECTORS = 0x8DFB;
	public var MAX_VARYING_VECTORS = 0x8DFC;
	public var MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D;
	public var MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C;
	public var MAX_TEXTURE_IMAGE_UNITS = 0x8872;
	public var MAX_FRAGMENT_UNIFORM_VECTORS = 0x8DFD;
	public var SHADER_TYPE = 0x8B4F;
	public var DELETE_STATUS = 0x8B80;
	public var LINK_STATUS = 0x8B82;
	public var VALIDATE_STATUS = 0x8B83;
	public var ATTACHED_SHADERS = 0x8B85;
	public var ACTIVE_UNIFORMS = 0x8B86;
	public var ACTIVE_UNIFORMS_MAX_LENGTH = 0x8B87;
	public var ACTIVE_ATTRIBUTES = 0x8B89;
	public var ACTIVE_ATTRIBUTES_MAX_LENGTH = 0x8B8A;
	public var SHADING_LANGUAGE_VERSION = 0x8B8C;
	public var CURRENT_PROGRAM = 0x8B8D;
	
	public var NEVER = 0x0200;
	public var LESS = 0x0201;
	public var EQUAL = 0x0202;
	public var LEQUAL = 0x0203;
	public var GREATER = 0x0204;
	public var NOTEQUAL = 0x0205;
	public var GEQUAL = 0x0206;
	public var ALWAYS = 0x0207;
	
	public var KEEP = 0x1E00;
	public var REPLACE = 0x1E01;
	public var INCR = 0x1E02;
	public var DECR = 0x1E03;
	public var INVERT = 0x150A;
	public var INCR_WRAP = 0x8507;
	public var DECR_WRAP = 0x8508;
	
	public var VENDOR = 0x1F00;
	public var RENDERER = 0x1F01;
	public var VERSION = 0x1F02;
	public var EXTENSIONS = 0x1F03;
	
	public var NEAREST = 0x2600;
	public var LINEAR = 0x2601;
	
	public var NEAREST_MIPMAP_NEAREST = 0x2700;
	public var LINEAR_MIPMAP_NEAREST = 0x2701;
	public var NEAREST_MIPMAP_LINEAR = 0x2702;
	public var LINEAR_MIPMAP_LINEAR = 0x2703;
	
	public var TEXTURE_MAG_FILTER = 0x2800;
	public var TEXTURE_MIN_FILTER = 0x2801;
	public var TEXTURE_WRAP_S = 0x2802;
	public var TEXTURE_WRAP_T = 0x2803;
	
	public var TEXTURE = 0x1702;
	
	public var TEXTURE_CUBE_MAP = 0x8513;
	public var TEXTURE_BINDING_CUBE_MAP = 0x8514;
	public var TEXTURE_CUBE_MAP_POSITIVE_X = 0x8515;
	public var TEXTURE_CUBE_MAP_NEGATIVE_X = 0x8516;
	public var TEXTURE_CUBE_MAP_POSITIVE_Y = 0x8517;
	public var TEXTURE_CUBE_MAP_NEGATIVE_Y = 0x8518;
	public var TEXTURE_CUBE_MAP_POSITIVE_Z = 0x8519;
	public var TEXTURE_CUBE_MAP_NEGATIVE_Z = 0x851A;
	public var MAX_CUBE_MAP_TEXTURE_SIZE = 0x851C;
	
	public var TEXTURE0 = 0x84C0;
	public var TEXTURE1 = 0x84C1;
	public var TEXTURE2 = 0x84C2;
	public var TEXTURE3 = 0x84C3;
	public var TEXTURE4 = 0x84C4;
	public var TEXTURE5 = 0x84C5;
	public var TEXTURE6 = 0x84C6;
	public var TEXTURE7 = 0x84C7;
	public var TEXTURE8 = 0x84C8;
	public var TEXTURE9 = 0x84C9;
	public var TEXTURE10 = 0x84CA;
	public var TEXTURE11 = 0x84CB;
	public var TEXTURE12 = 0x84CC;
	public var TEXTURE13 = 0x84CD;
	public var TEXTURE14 = 0x84CE;
	public var TEXTURE15 = 0x84CF;
	public var TEXTURE16 = 0x84D0;
	public var TEXTURE17 = 0x84D1;
	public var TEXTURE18 = 0x84D2;
	public var TEXTURE19 = 0x84D3;
	public var TEXTURE20 = 0x84D4;
	public var TEXTURE21 = 0x84D5;
	public var TEXTURE22 = 0x84D6;
	public var TEXTURE23 = 0x84D7;
	public var TEXTURE24 = 0x84D8;
	public var TEXTURE25 = 0x84D9;
	public var TEXTURE26 = 0x84DA;
	public var TEXTURE27 = 0x84DB;
	public var TEXTURE28 = 0x84DC;
	public var TEXTURE29 = 0x84DD;
	public var TEXTURE30 = 0x84DE;
	public var TEXTURE31 = 0x84DF;
	public var ACTIVE_TEXTURE = 0x84E0;
	
	public var REPEAT = 0x2901;
	public var CLAMP_TO_EDGE = 0x812F;
	public var MIRRORED_REPEAT = 0x8370;
	
	public var FLOAT_VEC2 = 0x8B50;
	public var FLOAT_VEC3 = 0x8B51;
	public var FLOAT_VEC4 = 0x8B52;
	public var INT_VEC2 = 0x8B53;
	public var INT_VEC3 = 0x8B54;
	public var INT_VEC4 = 0x8B55;
	public var BOOL = 0x8B56;
	public var BOOL_VEC2 = 0x8B57;
	public var BOOL_VEC3 = 0x8B58;
	public var BOOL_VEC4 = 0x8B59;
	public var FLOAT_MAT2 = 0x8B5A;
	public var FLOAT_MAT3 = 0x8B5B;
	public var FLOAT_MAT4 = 0x8B5C;
	public var SAMPLER_2D = 0x8B5E;
	public var SAMPLER_CUBE = 0x8B60;
	
	public var VERTEX_ATTRIB_ARRAY_ENABLED = 0x8622;
	public var VERTEX_ATTRIB_ARRAY_SIZE = 0x8623;
	public var VERTEX_ATTRIB_ARRAY_STRIDE = 0x8624;
	public var VERTEX_ATTRIB_ARRAY_TYPE = 0x8625;
	public var VERTEX_ATTRIB_ARRAY_NORMALIZED = 0x886A;
	public var VERTEX_ATTRIB_ARRAY_POINTER = 0x8645;
	public var VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F;
	
	public var IMPLEMENTATION_COLOR_READ_TYPE = 0x8B9A;
	public var IMPLEMENTATION_COLOR_READ_FORMAT = 0x8B9B;
	
	public var VERTEX_PROGRAM_POINT_SIZE = 0x8642;
	public var POINT_SPRITE = 0x8861;
	
	public var COMPILE_STATUS = 0x8B81;
	public var INFO_LOG_LENGTH = 0x8B84;
	public var SHADER_SOURCE_LENGTH = 0x8B88;
	public var SHADER_COMPILER = 0x8DFA;
	public var SHADER_BINARY_FORMATS = 0x8DF8;
	public var NUM_SHADER_BINARY_FORMATS = 0x8DF9;
	
	public var LOW_FLOAT = 0x8DF0;
	public var MEDIUM_FLOAT = 0x8DF1;
	public var HIGH_FLOAT = 0x8DF2;
	public var LOW_INT = 0x8DF3;
	public var MEDIUM_INT = 0x8DF4;
	public var HIGH_INT = 0x8DF5;
	
	public var FRAMEBUFFER = 0x8D40;
	public var RENDERBUFFER = 0x8D41;
	
	public var RGBA4 = 0x8056;
	public var RGB5_A1 = 0x8057;
	public var RGB565 = 0x8D62;
	public var DEPTH_COMPONENT16 = 0x81A5;
	public var STENCIL_INDEX = 0x1901;
	public var STENCIL_INDEX8 = 0x8D48;
	public var DEPTH_STENCIL = 0x84F9;
	
	public var RENDERBUFFER_WIDTH = 0x8D42;
	public var RENDERBUFFER_HEIGHT = 0x8D43;
	public var RENDERBUFFER_INTERNAL_FORMAT = 0x8D44;
	public var RENDERBUFFER_RED_SIZE = 0x8D50;
	public var RENDERBUFFER_GREEN_SIZE = 0x8D51;
	public var RENDERBUFFER_BLUE_SIZE = 0x8D52;
	public var RENDERBUFFER_ALPHA_SIZE = 0x8D53;
	public var RENDERBUFFER_DEPTH_SIZE = 0x8D54;
	public var RENDERBUFFER_STENCIL_SIZE = 0x8D55;
	
	public var FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 0x8CD0;
	public var FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 0x8CD1;
	public var FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 0x8CD2;
	public var FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3;
	
	public var COLOR_ATTACHMENT0 = 0x8CE0;
	public var DEPTH_ATTACHMENT = 0x8D00;
	public var STENCIL_ATTACHMENT = 0x8D20;
	public var DEPTH_STENCIL_ATTACHMENT = 0x821A;
	
	public var NONE = 0;
	
	public var FRAMEBUFFER_COMPLETE = 0x8CD5;
	public var FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 0x8CD6;
	public var FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7;
	public var FRAMEBUFFER_INCOMPLETE_DIMENSIONS = 0x8CD9;
	public var FRAMEBUFFER_UNSUPPORTED = 0x8CDD;
	
	public var FRAMEBUFFER_BINDING = 0x8CA6;
	public var RENDERBUFFER_BINDING = 0x8CA7;
	public var MAX_RENDERBUFFER_SIZE = 0x84E8;
	
	public var INVALID_FRAMEBUFFER_OPERATION = 0x0506;
	
	public var UNPACK_FLIP_Y_WEBGL = 0x9240;
	public var UNPACK_PREMULTIPLY_ALPHA_WEBGL = 0x9241;
	public var CONTEXT_LOST_WEBGL = 0x9242;
	public var UNPACK_COLORSPACE_CONVERSION_WEBGL = 0x9243;
	public var BROWSER_DEFAULT_WEBGL = 0x9244;
	
	public var READ_BUFFER = 0x0C02;
	public var UNPACK_ROW_LENGTH = 0x0CF2;
	public var UNPACK_SKIP_ROWS = 0x0CF3;
	public var UNPACK_SKIP_PIXELS = 0x0CF4;
	public var PACK_ROW_LENGTH = 0x0D02;
	public var PACK_SKIP_ROWS = 0x0D03;
	public var PACK_SKIP_PIXELS = 0x0D04;
	public var TEXTURE_BINDING_3D = 0x806A;
	public var UNPACK_SKIP_IMAGES = 0x806D;
	public var UNPACK_IMAGE_HEIGHT = 0x806E;
	public var MAX_3D_TEXTURE_SIZE = 0x8073;
	public var MAX_ELEMENTS_VERTICES = 0x80E8;
	public var MAX_ELEMENTS_INDICES = 0x80E9;
	public var MAX_TEXTURE_LOD_BIAS = 0x84FD;
	public var MAX_FRAGMENT_UNIFORM_COMPONENTS = 0x8B49;
	public var MAX_VERTEX_UNIFORM_COMPONENTS = 0x8B4A;
	public var MAX_ARRAY_TEXTURE_LAYERS = 0x88FF;
	public var MIN_PROGRAM_TEXEL_OFFSET = 0x8904;
	public var MAX_PROGRAM_TEXEL_OFFSET = 0x8905;
	public var MAX_VARYING_COMPONENTS = 0x8B4B;
	public var FRAGMENT_SHADER_DERIVATIVE_HINT = 0x8B8B;
	public var RASTERIZER_DISCARD = 0x8C89;
	public var VERTEX_ARRAY_BINDING = 0x85B5;
	public var MAX_VERTEX_OUTPUT_COMPONENTS = 0x9122;
	public var MAX_FRAGMENT_INPUT_COMPONENTS = 0x9125;
	public var MAX_SERVER_WAIT_TIMEOUT = 0x9111;
	public var MAX_ELEMENT_INDEX = 0x8D6B;
	
	public var RED = 0x1903;
	public var RGB8 = 0x8051;
	public var RGBA8 = 0x8058;
	public var RGB10_A2 = 0x8059;
	public var TEXTURE_3D = 0x806F;
	public var TEXTURE_WRAP_R = 0x8072;
	public var TEXTURE_MIN_LOD = 0x813A;
	public var TEXTURE_MAX_LOD = 0x813B;
	public var TEXTURE_BASE_LEVEL = 0x813C;
	public var TEXTURE_MAX_LEVEL = 0x813D;
	public var TEXTURE_COMPARE_MODE = 0x884C;
	public var TEXTURE_COMPARE_FUNC = 0x884D;
	public var SRGB = 0x8C40;
	public var SRGB8 = 0x8C41;
	public var SRGB8_ALPHA8 = 0x8C43;
	public var COMPARE_REF_TO_TEXTURE = 0x884E;
	public var RGBA32F = 0x8814;
	public var RGB32F = 0x8815;
	public var RGBA16F = 0x881A;
	public var RGB16F = 0x881B;
	public var TEXTURE_2D_ARRAY = 0x8C1A;
	public var TEXTURE_BINDING_2D_ARRAY = 0x8C1D;
	public var R11F_G11F_B10F = 0x8C3A;
	public var RGB9_E5 = 0x8C3D;
	public var RGBA32UI = 0x8D70;
	public var RGB32UI = 0x8D71;
	public var RGBA16UI = 0x8D76;
	public var RGB16UI = 0x8D77;
	public var RGBA8UI = 0x8D7C;
	public var RGB8UI = 0x8D7D;
	public var RGBA32I = 0x8D82;
	public var RGB32I = 0x8D83;
	public var RGBA16I = 0x8D88;
	public var RGB16I = 0x8D89;
	public var RGBA8I = 0x8D8E;
	public var RGB8I = 0x8D8F;
	public var RED_INTEGER = 0x8D94;
	public var RGB_INTEGER = 0x8D98;
	public var RGBA_INTEGER = 0x8D99;
	public var R8 = 0x8229;
	public var RG8 = 0x822B;
	public var R16F = 0x822D;
	public var R32F = 0x822E;
	public var RG16F = 0x822F;
	public var RG32F = 0x8230;
	public var R8I = 0x8231;
	public var R8UI = 0x8232;
	public var R16I = 0x8233;
	public var R16UI = 0x8234;
	public var R32I = 0x8235;
	public var R32UI = 0x8236;
	public var RG8I = 0x8237;
	public var RG8UI = 0x8238;
	public var RG16I = 0x8239;
	public var RG16UI = 0x823A;
	public var RG32I = 0x823B;
	public var RG32UI = 0x823C;
	public var R8_SNORM = 0x8F94;
	public var RG8_SNORM = 0x8F95;
	public var RGB8_SNORM = 0x8F96;
	public var RGBA8_SNORM = 0x8F97;
	public var RGB10_A2UI = 0x906F;
	public var TEXTURE_IMMUTABLE_FORMAT = 0x912F;
	public var TEXTURE_IMMUTABLE_LEVELS = 0x82DF;
	
	public var UNSIGNED_INT_2_10_10_10_REV = 0x8368;
	public var UNSIGNED_INT_10F_11F_11F_REV = 0x8C3B;
	public var UNSIGNED_INT_5_9_9_9_REV = 0x8C3E;
	public var FLOAT_32_UNSIGNED_INT_24_8_REV = 0x8DAD;
	public var UNSIGNED_INT_24_8 = 0x84FA;
	public var HALF_FLOAT = 0x140B;
	public var RG = 0x8227;
	public var RG_INTEGER = 0x8228;
	public var INT_2_10_10_10_REV = 0x8D9F;
	
	public var CURRENT_QUERY = 0x8865;
	public var QUERY_RESULT = 0x8866;
	public var QUERY_RESULT_AVAILABLE = 0x8867;
	public var ANY_SAMPLES_PASSED = 0x8C2F;
	public var ANY_SAMPLES_PASSED_CONSERVATIVE = 0x8D6A;
	
	public var MAX_DRAW_BUFFERS = 0x8824;
	public var DRAW_BUFFER0 = 0x8825;
	public var DRAW_BUFFER1 = 0x8826;
	public var DRAW_BUFFER2 = 0x8827;
	public var DRAW_BUFFER3 = 0x8828;
	public var DRAW_BUFFER4 = 0x8829;
	public var DRAW_BUFFER5 = 0x882A;
	public var DRAW_BUFFER6 = 0x882B;
	public var DRAW_BUFFER7 = 0x882C;
	public var DRAW_BUFFER8 = 0x882D;
	public var DRAW_BUFFER9 = 0x882E;
	public var DRAW_BUFFER10 = 0x882F;
	public var DRAW_BUFFER11 = 0x8830;
	public var DRAW_BUFFER12 = 0x8831;
	public var DRAW_BUFFER13 = 0x8832;
	public var DRAW_BUFFER14 = 0x8833;
	public var DRAW_BUFFER15 = 0x8834;
	public var MAX_COLOR_ATTACHMENTS = 0x8CDF;
	public var COLOR_ATTACHMENT1 = 0x8CE1;
	public var COLOR_ATTACHMENT2 = 0x8CE2;
	public var COLOR_ATTACHMENT3 = 0x8CE3;
	public var COLOR_ATTACHMENT4 = 0x8CE4;
	public var COLOR_ATTACHMENT5 = 0x8CE5;
	public var COLOR_ATTACHMENT6 = 0x8CE6;
	public var COLOR_ATTACHMENT7 = 0x8CE7;
	public var COLOR_ATTACHMENT8 = 0x8CE8;
	public var COLOR_ATTACHMENT9 = 0x8CE9;
	public var COLOR_ATTACHMENT10 = 0x8CEA;
	public var COLOR_ATTACHMENT11 = 0x8CEB;
	public var COLOR_ATTACHMENT12 = 0x8CEC;
	public var COLOR_ATTACHMENT13 = 0x8CED;
	public var COLOR_ATTACHMENT14 = 0x8CEE;
	public var COLOR_ATTACHMENT15 = 0x8CEF;
	
	public var SAMPLER_3D = 0x8B5F;
	public var SAMPLER_2D_SHADOW = 0x8B62;
	public var SAMPLER_2D_ARRAY = 0x8DC1;
	public var SAMPLER_2D_ARRAY_SHADOW = 0x8DC4;
	public var SAMPLER_CUBE_SHADOW = 0x8DC5;
	public var INT_SAMPLER_2D = 0x8DCA;
	public var INT_SAMPLER_3D = 0x8DCB;
	public var INT_SAMPLER_CUBE = 0x8DCC;
	public var INT_SAMPLER_2D_ARRAY = 0x8DCF;
	public var UNSIGNED_INT_SAMPLER_2D = 0x8DD2;
	public var UNSIGNED_INT_SAMPLER_3D = 0x8DD3;
	public var UNSIGNED_INT_SAMPLER_CUBE = 0x8DD4;
	public var UNSIGNED_INT_SAMPLER_2D_ARRAY = 0x8DD7;
	public var MAX_SAMPLES = 0x8D57;
	public var SAMPLER_BINDING = 0x8919;
	
	public var PIXEL_PACK_BUFFER = 0x88EB;
	public var PIXEL_UNPACK_BUFFER = 0x88EC;
	public var PIXEL_PACK_BUFFER_BINDING = 0x88ED;
	public var PIXEL_UNPACK_BUFFER_BINDING = 0x88EF;
	public var COPY_READ_BUFFER = 0x8F36;
	public var COPY_WRITE_BUFFER = 0x8F37;
	public var COPY_READ_BUFFER_BINDING = 0x8F36;
	public var COPY_WRITE_BUFFER_BINDING = 0x8F37;
	
	public var FLOAT_MAT2x3 = 0x8B65;
	public var FLOAT_MAT2x4 = 0x8B66;
	public var FLOAT_MAT3x2 = 0x8B67;
	public var FLOAT_MAT3x4 = 0x8B68;
	public var FLOAT_MAT4x2 = 0x8B69;
	public var FLOAT_MAT4x3 = 0x8B6A;
	public var UNSIGNED_INT_VEC2 = 0x8DC6;
	public var UNSIGNED_INT_VEC3 = 0x8DC7;
	public var UNSIGNED_INT_VEC4 = 0x8DC8;
	public var UNSIGNED_NORMALIZED = 0x8C17;
	public var SIGNED_NORMALIZED = 0x8F9C;
	
	public var VERTEX_ATTRIB_ARRAY_INTEGER = 0x88FD;
	public var VERTEX_ATTRIB_ARRAY_DIVISOR = 0x88FE;
	
	public var TRANSFORM_FEEDBACK_BUFFER_MODE = 0x8C7F;
	public var MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = 0x8C80;
	public var TRANSFORM_FEEDBACK_VARYINGS = 0x8C83;
	public var TRANSFORM_FEEDBACK_BUFFER_START = 0x8C84;
	public var TRANSFORM_FEEDBACK_BUFFER_SIZE = 0x8C85;
	public var TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = 0x8C88;
	public var MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 0x8C8A;
	public var MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 0x8C8B;
	public var INTERLEAVED_ATTRIBS = 0x8C8C;
	public var SEPARATE_ATTRIBS = 0x8C8D;
	public var TRANSFORM_FEEDBACK_BUFFER = 0x8C8E;
	public var TRANSFORM_FEEDBACK_BUFFER_BINDING = 0x8C8F;
	public var TRANSFORM_FEEDBACK = 0x8E22;
	public var TRANSFORM_FEEDBACK_PAUSED = 0x8E23;
	public var TRANSFORM_FEEDBACK_ACTIVE = 0x8E24;
	public var TRANSFORM_FEEDBACK_BINDING = 0x8E25;
	
	public var FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 0x8210;
	public var FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 0x8211;
	public var FRAMEBUFFER_ATTACHMENT_RED_SIZE = 0x8212;
	public var FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 0x8213;
	public var FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 0x8214;
	public var FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 0x8215;
	public var FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 0x8216;
	public var FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 0x8217;
	public var FRAMEBUFFER_DEFAULT = 0x8218;
	public var DEPTH24_STENCIL8 = 0x88F0;
	public var DRAW_FRAMEBUFFER_BINDING = 0x8CA6;
	public var READ_FRAMEBUFFER = 0x8CA8;
	public var DRAW_FRAMEBUFFER = 0x8CA9;
	public var READ_FRAMEBUFFER_BINDING = 0x8CAA;
	public var RENDERBUFFER_SAMPLES = 0x8CAB;
	public var FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 0x8CD4;
	public var FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 0x8D56;
	
	public var UNIFORM_BUFFER = 0x8A11;
	public var UNIFORM_BUFFER_BINDING = 0x8A28;
	public var UNIFORM_BUFFER_START = 0x8A29;
	public var UNIFORM_BUFFER_SIZE = 0x8A2A;
	public var MAX_VERTEX_UNIFORM_BLOCKS = 0x8A2B;
	public var MAX_FRAGMENT_UNIFORM_BLOCKS = 0x8A2D;
	public var MAX_COMBINED_UNIFORM_BLOCKS = 0x8A2E;
	public var MAX_UNIFORM_BUFFER_BINDINGS = 0x8A2F;
	public var MAX_UNIFORM_BLOCK_SIZE = 0x8A30;
	public var MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = 0x8A31;
	public var MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = 0x8A33;
	public var UNIFORM_BUFFER_OFFSET_ALIGNMENT = 0x8A34;
	public var ACTIVE_UNIFORM_BLOCKS = 0x8A36;
	public var UNIFORM_TYPE = 0x8A37;
	public var UNIFORM_SIZE = 0x8A38;
	public var UNIFORM_BLOCK_INDEX = 0x8A3A;
	public var UNIFORM_OFFSET = 0x8A3B;
	public var UNIFORM_ARRAY_STRIDE = 0x8A3C;
	public var UNIFORM_MATRIX_STRIDE = 0x8A3D;
	public var UNIFORM_IS_ROW_MAJOR = 0x8A3E;
	public var UNIFORM_BLOCK_BINDING = 0x8A3F;
	public var UNIFORM_BLOCK_DATA_SIZE = 0x8A40;
	public var UNIFORM_BLOCK_ACTIVE_UNIFORMS = 0x8A42;
	public var UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = 0x8A43;
	public var UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = 0x8A44;
	public var UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = 0x8A46;
	
	public var OBJECT_TYPE = 0x9112;
	public var SYNC_CONDITION = 0x9113;
	public var SYNC_STATUS = 0x9114;
	public var SYNC_FLAGS = 0x9115;
	public var SYNC_FENCE = 0x9116;
	public var SYNC_GPU_COMMANDS_COMPLETE = 0x9117;
	public var UNSIGNALED = 0x9118;
	public var SIGNALED = 0x9119;
	public var ALREADY_SIGNALED = 0x911A;
	public var TIMEOUT_EXPIRED = 0x911B;
	public var CONDITION_SATISFIED = 0x911C;
	public var WAIT_FAILED = 0x911D;
	public var SYNC_FLUSH_COMMANDS_BIT = 0x00000001;
	
	public var COLOR = 0x1800;
	public var DEPTH = 0x1801;
	public var STENCIL = 0x1802;
	public var MIN = 0x8007;
	public var MAX = 0x8008;
	public var DEPTH_COMPONENT24 = 0x81A6;
	public var STREAM_READ = 0x88E1;
	public var STREAM_COPY = 0x88E2;
	public var STATIC_READ = 0x88E5;
	public var STATIC_COPY = 0x88E6;
	public var DYNAMIC_READ = 0x88E9;
	public var DYNAMIC_COPY = 0x88EA;
	public var DEPTH_COMPONENT32F = 0x8CAC;
	public var DEPTH32F_STENCIL8 = 0x8CAD;
	public var INVALID_INDEX = 0xFFFFFFFF;
	public var TIMEOUT_IGNORED = -1;
	public var MAX_CLIENT_WAIT_TIMEOUT_WEBGL = 0x9247;
	
	public var type (default, null):GLContextType;
	public var version (default, null):Float;
	
	private var __arrayBufferBinding:GLBuffer;
	private var __elementBufferBinding:GLBuffer;
	private var __contextID:Int;
	private var __currentProgram:GLProgram;
	private var __framebufferBinding:GLFramebuffer;
	private var __initialized:Bool;
	private var __isContextLost:Bool;
	private var __renderbufferBinding:GLRenderbuffer;
	private var __texture2DBinding:GLTexture;
	private var __textureCubeMapBinding:GLTexture;
	
	
	private function new () {
		
		__contextID = __lastContextID++;
		
		__initialize ();
		
		#if (lime_cffi && lime_opengl && !macro)
		var versionString:String = getParameter (VERSION);
		if (versionString.indexOf ("OpenGL ES") > -1) {
			type = GLES;
		} else {
			type = OPENGL;
		}
		var ereg = ~/[0-9]+[.]?[0-9]?/i;
		if (ereg.match (versionString)) {
			version = Std.parseFloat (ereg.matched (0));
		} else {
			version = 2;
		}
		#else
		type = OPENGL;
		version = 2;
		#end
		
	}
	
	
	public function activeTexture (texture:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_active_texture (texture);
		#end
		
	}
	
	
	public function attachShader (program:GLProgram, shader:GLShader):Void {
		
		if (program != null && shader != null && program.shaders.indexOf (shader) == -1) {
			
			program.shaders.push (shader);
			
		}
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_attach_shader (program, shader);
		#end
		
	}
	
	
	public function bindAttribLocation (program:GLProgram, index:Int, name:String):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_bind_attrib_location (program, index, name);
		#end
		
	}
	
	
	public function bindBuffer (target:Int, buffer:GLBuffer):Void {
		
		if (target == ARRAY_BUFFER) __arrayBufferBinding = buffer;
		if (target == ELEMENT_ARRAY_BUFFER) __elementBufferBinding = buffer;
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_bind_buffer (target, buffer);
		#end
		
	}
	
	
	public function bindFramebuffer (target:Int, framebuffer:GLFramebuffer):Void {
		
		__framebufferBinding = framebuffer;
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_bind_framebuffer (target, framebuffer);
		#end
		
	}
	
	
	public function bindRenderbuffer (target:Int, renderbuffer:GLRenderbuffer):Void {
		
		__renderbufferBinding = renderbuffer;
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_bind_renderbuffer (target, renderbuffer);
		#end
		
	}
	
	
	public function bindTexture (target:Int, texture:GLTexture):Void {
		
		if (target == TEXTURE_2D) __texture2DBinding = texture;
		if (target == TEXTURE_CUBE_MAP) __textureCubeMapBinding = texture;
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_bind_texture (target, texture);
		#end
		
	}
	
	
	public function blendColor (red:Float, green:Float, blue:Float, alpha:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_blend_color (red, green, blue, alpha);
		#end
		
	}
	
	
	public function blendEquation (mode:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_blend_equation (mode);
		#end
		
	}
	
	
	public function blendEquationSeparate (modeRGB:Int, modeAlpha:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_blend_equation_separate (modeRGB, modeAlpha);
		#end
		
	}
	
	
	public function blendFunc (sfactor:Int, dfactor:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_blend_func (sfactor, dfactor);
		#end
		
	}
	
	
	public function blendFuncSeparate (srcRGB:Int, dstRGB:Int, srcAlpha:Int, dstAlpha:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_blend_func_separate (srcRGB, dstRGB, srcAlpha, dstAlpha);
		#end
		
	}
	
	
	public function bufferData (target:Int, size:Int, srcData:DataPointer, usage:Int, srcOffset:Int = 0, length:Int = 0):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_buffer_data (target, size, srcData, usage);
		#end
		
	}
	
	
	public function bufferSubData (target:Int, dstByteOffset:Int, size:Int, srcData:DataPointer, srcOffset:Int = 0, length:Int = 0):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_buffer_sub_data (target, dstByteOffset, size, srcData);
		#end
		
	}
	
	
	public function checkFramebufferStatus (target:Int):Int {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_check_framebuffer_status (target);
		#else
		return 0;
		#end
		
	}
	
	
	public function clear (mask:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_clear (mask);
		#end
		
	}
	
	
	public function clearColor (red:Float, green:Float, blue:Float, alpha:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_clear_color (red, green, blue, alpha);
		#end
		
	}
	
	
	public function clearDepth (depth:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_clear_depth (depth);
		#end
		
	}
	
	
	public function clearStencil (s:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_clear_stencil (s);
		#end
		
	}
	
	
	public function colorMask (red:Bool, green:Bool, blue:Bool, alpha:Bool):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_color_mask (red, green, blue, alpha);
		#end
		
	}
	
	
	public function compileShader (shader:GLShader):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_compile_shader (shader);
		#end
		
	}
	
	
	public function compressedTexImage2D (target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, imageSize:Int, srcData:DataPointer, srcOffset:Int = 0, srcLengthOverride:Int = 0):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_compressed_tex_image_2d (target, level, internalformat, width, height, border, imageSize, srcData);
		#end
		
	}
	
	
	public function compressedTexSubImage2D (target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, imageSize:Int, srcData:DataPointer, srcOffset:Int = 0, srcLengthOverride:Int = 0):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_compressed_tex_sub_image_2d (target, level, xoffset, yoffset, width, height, format, imageSize, srcData);
		#end
		
	}
	
	
	public function copyTexImage2D (target:Int, level:Int, internalformat:Int, x:Int, y:Int, width:Int, height:Int, border:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_copy_tex_image_2d (target, level, internalformat, x, y, width, height, border);
		#end
		
	}
	
	
	public function copyTexSubImage2D (target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_copy_tex_sub_image_2d (target, level, xoffset, yoffset, x, y, width, height);
		#end
		
	}
	
	
	public function createBuffer ():GLBuffer {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_create_buffer ();
		#else
		return null;
		#end
		
	}
	
	
	public function createFramebuffer ():GLFramebuffer {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_create_framebuffer ();
		#else
		return null;
		#end
		
	}
	
	
	public function createProgram ():GLProgram {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_create_program ();
		#else
		return null;
		#end
		
	}
	
	
	public function createRenderbuffer ():GLRenderbuffer {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_create_renderbuffer ();
		#else
		return null;
		#end
		
	}
	
	
	public function createShader (type:Int):GLShader {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_create_shader (type);
		#else
		return null;
		#end
		
	}
	
	
	public function createTexture ():GLTexture {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_create_texture ();
		#else
		return null;
		#end
		
	}
	
	
	public function cullFace (mode:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_cull_face (mode);
		#end
		
	}
	
	
	public function deleteBuffer (buffer:GLBuffer):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_delete_buffer (buffer);
		#end
		
	}
	
	
	public function deleteFramebuffer (framebuffer:GLFramebuffer):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_delete_framebuffer (framebuffer);
		#end
		
	}
	
	
	public function deleteProgram (program:GLProgram):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_delete_program (program);
		#end
		
	}
	
	
	public function deleteRenderbuffer (renderbuffer:GLRenderbuffer):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_delete_renderbuffer (renderbuffer);
		#end
		
	}
	
	
	public function deleteShader (shader:GLShader):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_delete_shader (shader);
		#end
		
	}
	
	
	public function deleteTexture (texture:GLTexture):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_delete_texture (texture);
		#end
		
	}
	
	
	public function depthFunc (func:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_depth_func (func);
		#end
		
	}
	
	
	public function depthMask (flag:Bool):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_depth_mask (flag);
		#end
		
	}
	
	
	public function depthRange (zNear:Float, zFar:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_depth_range (zNear, zFar);
		#end
		
	}
	
	
	public function detachShader (program:GLProgram, shader:GLShader):Void {
		
		if (program != null) {
			
			program.shaders.remove (shader);
			
		}
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_detach_shader (program, shader);
		#end
		
	}
	
	
	public function disable (cap:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_disable (cap);
		#end
		
	}
	
	
	public function disableVertexAttribArray (index:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_disable_vertex_attrib_array (index);
		#end
		
	}
	
	
	public function drawArrays (mode:Int, first:Int, count:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_draw_arrays (mode, first, count);
		#end
		
	}
	
	
	public function drawElements (mode:Int, count:Int, type:Int, offset:DataPointer):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_draw_elements (mode, count, type, offset);
		#end
		
	}
	
	
	public function enable (cap:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_enable (cap);
		#end
		
	}
	
	
	public function enableVertexAttribArray (index:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_enable_vertex_attrib_array (index);
		#end
		
	}
	
	
	public function finish ():Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_finish ();
		#end
		
	}
	
	
	public function flush ():Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_flush ();
		#end
		
	}
	
	
	public function framebufferRenderbuffer (target:Int, attachment:Int, renderbuffertarget:Int, renderbuffer:GLRenderbuffer):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_framebuffer_renderbuffer (target, attachment, renderbuffertarget, renderbuffer);
		#end
		
	}
	
	
	public function framebufferTexture2D (target:Int, attachment:Int, textarget:Int, texture:GLTexture, level:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_framebuffer_texture2D (target, attachment, textarget, texture, level);
		#end
		
	}
	
	
	public function frontFace (mode:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_front_face (mode);
		#end
		
	}
	
	
	public function generateMipmap (target:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_generate_mipmap (target);
		#end
		
	}
	
	
	public function getActiveAttrib (program:GLProgram, index:Int):GLActiveInfo {
		
		#if (lime_cffi && lime_opengl && !macro)
		var result:Dynamic = NativeCFFI.lime_gl_get_active_attrib (program, index);
		return result;
		#else
		return null;
		#end
		
	}
	
	
	public function getActiveUniform (program:GLProgram, index:Int):GLActiveInfo {
		
		#if (lime_cffi && lime_opengl && !macro)
		var result:Dynamic = NativeCFFI.lime_gl_get_active_uniform (program, index);
		return result;
		#else
		return null;
		#end
		
	}
	
	
	public function getAttachedShaders (program:GLProgram):Array<GLShader> {
		
		return program.shaders;
		
		//#if (lime_cffi && lime_opengl && !macro)
		//return program.__attachedShaders;
		//#else
		//return null;
		//#end
		
	}
	
	
	public function getAttribLocation (program:GLProgram, name:String):Int {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_attrib_location (program, name);
		#else
		return 0;
		#end
		
	}
	
	
	public function getBoolean (pname:Int):Bool {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_boolean (pname);
		#else
		return false;
		#end
		
	}
	
	
	public function getBooleanv (pname:Int):Array<Bool> {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_booleanv (pname);
		#else
		return null;
		#end
		
	}
	
	
	public function getBufferParameter (target:Int, pname:Int):Dynamic {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_buffer_parameter (target, pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function getContextAttributes ():GLContextAttributes {
		
		#if (lime_cffi && lime_opengl && !macro)
		var base:Dynamic = NativeCFFI.lime_gl_get_context_attributes ();
		base.premultipliedAlpha = false;
		base.preserveDrawingBuffer = false;
		return base;
		#else
		return null;
		#end
		
	}
	
	
	public function getError ():Int {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_error ();
		#else
		return 0;
		#end
		
	}
	
	
	public function getExtension (name:String):Dynamic {
		
		if (__extensionObjects == null) {
			
			__extensionObjects = new Map ();
			var supportedExtensions = getSupportedExtensions ();
			
			for (extension in supportedExtensions) {
				
				if (__extensionObjectTypes.exists (extension)) {
					
					__extensionObjects.set (extension, null);
					
				}
				
			}
			
		}
		
		if (__extensionObjects.exists (name)) {
			
			var object = __extensionObjects.get (name);
			
			if (object == null) {
				
				object = Type.createInstance (__extensionObjectTypes.get (name), []);
				__extensionObjects.set (name, object);
				
			}
			
			return object;
			
		} else {
			
			return null;
			
		}
		
	}
	
	
	public function getFloat (pname:Int):Float {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_float (pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function getFloatv (pname:Int):Array<Float> {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_floatv (pname);
		#else
		return null;
		#end
		
	}
	
	
	public function getFramebufferAttachmentParameter (target:Int, attachment:Int, pname:Int):Dynamic {
		
		// TODO: FRAMEBUFFER_ATTACHMENT_OBJECT_NAME
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_framebuffer_attachment_parameter (target, attachment, pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function getInteger (pname:Int):Int {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_integer (pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function getIntegerv (pname:Int):Array<Int> {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_integerv (pname);
		#else
		return null;
		#end
		
	}
	
	
	public function getParameter (pname:Int):Dynamic {
		
		switch (pname) {
			
			case GL.BLEND, GL.CULL_FACE, GL.DEPTH_TEST, GL.DEPTH_WRITEMASK, GL.DITHER, GL.POLYGON_OFFSET_FILL, GL.SAMPLE_COVERAGE_INVERT, GL.SCISSOR_TEST, GL.STENCIL_TEST, GL.UNPACK_FLIP_Y_WEBGL, GL.UNPACK_PREMULTIPLY_ALPHA_WEBGL:
				
				return getBoolean (pname);
			
			case GL.COLOR_WRITEMASK:
				
				return getBooleanv (pname);
			
			case GL.DEPTH_CLEAR_VALUE, GL.LINE_WIDTH, GL.POLYGON_OFFSET_FACTOR, GL.POLYGON_OFFSET_UNITS, GL.SAMPLE_COVERAGE_VALUE:
				
				return getFloat (pname);
			
			case GL.ALIASED_LINE_WIDTH_RANGE, GL.ALIASED_POINT_SIZE_RANGE, GL.BLEND_COLOR, GL.COLOR_CLEAR_VALUE, GL.DEPTH_RANGE:
				
				return getFloatv (pname);
			
			case GL.ACTIVE_TEXTURE, GL.ALPHA_BITS, GL.BLEND_DST_ALPHA, GL.BLEND_DST_RGB, GL.BLEND_EQUATION, GL.BLEND_EQUATION_ALPHA, GL.BLEND_EQUATION_RGB, GL.BLEND_SRC_ALPHA, GL.BLEND_SRC_RGB, GL.BLUE_BITS, GL.CULL_FACE_MODE, GL.DEPTH_BITS, GL.DEPTH_FUNC, GL.FRONT_FACE, GL.GENERATE_MIPMAP_HINT, GL.GREEN_BITS, GL.IMPLEMENTATION_COLOR_READ_FORMAT, GL.IMPLEMENTATION_COLOR_READ_TYPE, GL.MAX_COMBINED_TEXTURE_IMAGE_UNITS, GL.MAX_CUBE_MAP_TEXTURE_SIZE, GL.MAX_FRAGMENT_UNIFORM_VECTORS, GL.MAX_RENDERBUFFER_SIZE, GL.MAX_TEXTURE_IMAGE_UNITS, GL.MAX_TEXTURE_SIZE, GL.MAX_VARYING_VECTORS, GL.MAX_VERTEX_ATTRIBS, GL.MAX_VERTEX_TEXTURE_IMAGE_UNITS, GL.MAX_VERTEX_UNIFORM_VECTORS, GL.PACK_ALIGNMENT, GL.RED_BITS, GL.SAMPLE_BUFFERS, GL.SAMPLES, GL.STENCIL_BACK_FAIL, GL.STENCIL_BACK_FUNC, GL.STENCIL_BACK_PASS_DEPTH_FAIL, GL.STENCIL_BACK_PASS_DEPTH_PASS, GL.STENCIL_BACK_REF, GL.STENCIL_BACK_VALUE_MASK, GL.STENCIL_BACK_WRITEMASK, GL.STENCIL_BITS, GL.STENCIL_CLEAR_VALUE, GL.STENCIL_FAIL, GL.STENCIL_FUNC, GL.STENCIL_PASS_DEPTH_FAIL, GL.STENCIL_PASS_DEPTH_PASS, GL.STENCIL_REF, GL.STENCIL_VALUE_MASK, GL.STENCIL_WRITEMASK, GL.SUBPIXEL_BITS, GL.UNPACK_ALIGNMENT, GL.UNPACK_COLORSPACE_CONVERSION_WEBGL:
				
				return getInteger (pname);
			
			case GL.COMPRESSED_TEXTURE_FORMATS, GL.MAX_VIEWPORT_DIMS, GL.SCISSOR_BOX, GL.VIEWPORT:
				
				return getIntegerv (pname);
			
			case GL.RENDERER, GL.SHADING_LANGUAGE_VERSION, GL.VENDOR, GL.VERSION:
				
				return getString (pname);
			
			// TODO: Handle if context is modified elsewhere
			
			case GL.ARRAY_BUFFER_BINDING:
				
				return __arrayBufferBinding;
			
			case GL.ELEMENT_ARRAY_BUFFER_BINDING:
				
				return __elementBufferBinding;
			
			case GL.CURRENT_PROGRAM:
				
				return __currentProgram;
			
			case GL.FRAMEBUFFER_BINDING:
				
				return __framebufferBinding;
			
			case GL.TEXTURE_BINDING_2D:
				
				return __texture2DBinding;
			
			case GL.TEXTURE_BINDING_CUBE_MAP:
				
				return __textureCubeMapBinding;
			
			default:
				
				return null;
			
		}
		
	}
	
	
	public function getProgramInfoLog (program:GLProgram):String {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_program_info_log (program);
		#else
		return null;
		#end
		
	}
	
	
	public function getProgramParameter (program:GLProgram, pname:Int):Dynamic {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_program_parameter (program, pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function getRenderbufferParameter (target:Int, pname:Int):Dynamic {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_renderbuffer_parameter (target, pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function getShaderInfoLog (shader:GLShader):String {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_shader_info_log (shader);
		#else
		return null;
		#end
		
	}
	
	
	public function getShaderParameter (shader:GLShader, pname:Int):Dynamic {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_shader_parameter (shader, pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function getShaderPrecisionFormat (shadertype:Int, precisiontype:Int):GLShaderPrecisionFormat {
		
		#if (lime_cffi && lime_opengl && !macro)
		var result:Dynamic = NativeCFFI.lime_gl_get_shader_precision_format (shadertype, precisiontype);
		return result;
		#else
		return null;
		#end
		
	}
	
	
	public function getShaderSource (shader:GLShader):String {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_shader_source (shader);
		#else
		return null;
		#end
		
	}
	
	
	public function getString (pname:Int):String {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_string (pname);
		#else
		return null;
		#end
		
	}
	
	
	public function getSupportedExtensions ():Array<String> {
		
		if (__supportedExtensions == null) {
			
			__supportedExtensions = new Array<String> ();
			
			#if (lime_cffi && lime_opengl && !macro)
			NativeCFFI.lime_gl_get_supported_extensions (__supportedExtensions);
			
			for (i in 0...__supportedExtensions.length) {
				
				if (StringTools.startsWith (__supportedExtensions[i], "GL_")) {
					
					__supportedExtensions[i] = __supportedExtensions[i].substr (3);
					
				}
				
			}
			#end
			
		}
		
		return __supportedExtensions;
		
	}
	
	
	public function getTexParameter (target:Int, pname:Int):Dynamic {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_tex_parameter (target, pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function getUniform (program:GLProgram, location:GLUniformLocation):Dynamic {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_uniform (program, location);
		#else
		return null;
		#end
		
	}
	
	
	public function getUniformLocation (program:GLProgram, name:String):GLUniformLocation {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_uniform_location (program, name);
		#else
		return 0;
		#end
		
	}
	
	
	public function getVertexAttrib (index:Int, pname:Int):Dynamic {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_vertex_attrib (index, pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function getVertexAttribOffset (index:Int, pname:Int):DataPointer {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_get_vertex_attrib_offset (index, pname);
		#else
		return 0;
		#end
		
	}
	
	
	public function hint (target:Int, mode:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_hint (target, mode);
		#end
		
	}
	
	
	public function isBuffer (buffer:GLBuffer):Bool {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_is_buffer (buffer);
		#else
		return false;
		#end
		
	}
	
	
	public function isContextLost ():Bool {
		
		return __isContextLost;
		
	}
	
	
	public function isEnabled (cap:Int):Bool {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_is_enabled (cap);
		#else
		return false;
		#end
		
	}
	
	
	public function isFramebuffer (framebuffer:GLFramebuffer):Bool {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_is_framebuffer (framebuffer);
		#else
		return false;
		#end
		
	}
	
	
	public function isProgram (program:GLProgram):Bool {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_is_program (program);
		#else
		return false;
		#end
		
	}
	
	
	public function isRenderbuffer (renderbuffer:GLRenderbuffer):Bool {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_is_renderbuffer (renderbuffer);
		#else
		return false;
		#end
		
	}
	
	
	public function isShader (shader:GLShader):Bool {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_is_shader (shader);
		#else
		return false;
		#end
		
	}
	
	
	public function isTexture (texture:GLTexture):Bool {
		
		#if (lime_cffi && lime_opengl && !macro)
		return NativeCFFI.lime_gl_is_texture (texture);
		#else
		return false;
		#end
		
	}
	
	
	public function lineWidth (width:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_line_width (width);
		#end
		
	}
	
	
	public function linkProgram (program:GLProgram):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_link_program (program);
		#end
		
	}
	
	
	public function pixelStorei (pname:Int, param:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_pixel_storei (pname, param);
		#end
		
	}
	
	
	public function polygonOffset (factor:Float, units:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_polygon_offset (factor, units);
		#end
		
	}
	
	
	public function readPixels (x:Int, y:Int, width:Int, height:Int, format:Int, type:Int, pixels:DataPointer, dstOffset:Int = 0):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_read_pixels (x, y, width, height, format, type, pixels);
		#end
		
	}
	
	
	public function renderbufferStorage (target:Int, internalformat:Int, width:Int, height:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_renderbuffer_storage (target, internalformat, width, height);
		#end
		
	}
	
	
	public function sampleCoverage (value:Float, invert:Bool):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_sample_coverage (value, invert);
		#end
		
	}
	
	
	public function scissor (x:Int, y:Int, width:Int, height:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_scissor (x, y, width, height);
		#end
		
	}
	
	
	public function shaderSource (shader:GLShader, source:String):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_shader_source (shader, source);
		#end
		
	}
	
	
	public function stencilFunc (func:Int, ref:Int, mask:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_stencil_func (func, ref, mask);
		#end
		
	}
	
	
	public function stencilFuncSeparate (face:Int, func:Int, ref:Int, mask:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_stencil_func_separate (face, func, ref, mask);
		#end
		
	}
	
	
	public function stencilMask (mask:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_stencil_mask (mask);
		#end
		
	}
	
	
	public function stencilMaskSeparate (face:Int, mask:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_stencil_mask_separate (face, mask);
		#end
		
	}
	
	
	public function stencilOp (fail:Int, zfail:Int, zpass:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_stencil_op (fail, zfail, zpass);
		#end
		
	}
	
	
	public function stencilOpSeparate (face:Int, fail:Int, zfail:Int, zpass:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_stencil_op_separate (face, fail, zfail, zpass);
		#end
		
	}
	
	
	public function texImage2D (target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, srcData:DataPointer, srcOffset:Int = 0):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_tex_image_2d (target, level, internalformat, width, height, border, format, type, srcData);
		#end
		
	}
	
	
	public function texParameterf (target:Int, pname:Int, param:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_tex_parameterf (target, pname, param);
		#end
		
	}
	
	
	public function texParameteri (target:Int, pname:Int, param:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_tex_parameteri (target, pname, param);
		#end
		
	}
	
	
	public function texSubImage2D (target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, type:Int, pixels:DataPointer):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_tex_sub_image_2d (target, level, xoffset, yoffset, width, height, format, type, pixels);
		#end
		
	}
	
	
	public function uniform1f (location:GLUniformLocation, x:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform1f (location, x);
		#end
		
	}
	
	
	public function uniform1fv (location:GLUniformLocation, x:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform1fv (location, x.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform1fv (location, x);
		#end
		
	}
	
	
	public function uniform1i (location:GLUniformLocation, x:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform1i (location, x);
		#end
		
	}
	
	
	public function uniform1iv (location:GLUniformLocation, v:Int32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform1iv (location, v.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform1iv (location, v);
		#end
		
	}
	
	
	public function uniform2f (location:GLUniformLocation, x:Float, y:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform2f (location, x, y);
		#end
		
	}
	
	
	public function uniform2fv (location:GLUniformLocation, v:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform2fv (location, v.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform2fv (location, v);
		#end
		
	}
	
	
	public function uniform2i (location:GLUniformLocation, x:Int, y:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform2i (location, x, y);
		#end
		
	}
	
	
	public function uniform2iv (location:GLUniformLocation, v:Int32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform2iv (location, v.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform2iv (location, v);
		#end
		
	}
	
	
	public function uniform3f (location:GLUniformLocation, x:Float, y:Float, z:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform3f (location, x, y, z);
		#end
		
	}
	
	
	public function uniform3fv (location:GLUniformLocation, v:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform3fv (location, v.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform3fv (location, v);
		#end
		
	}
	
	
	public function uniform3i (location:GLUniformLocation, x:Int, y:Int, z:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform3i (location, x, y, z);
		#end
		
	}
	
	
	public function uniform3iv (location:GLUniformLocation, v:Int32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform3iv (location, v.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform3iv (location, v);
		#end
		
	}
	
	
	public function uniform4f (location:GLUniformLocation, x:Float, y:Float, z:Float, w:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform4f (location, x, y, z, w);
		#end
		
	}
	
	
	public function uniform4fv (location:GLUniformLocation, v:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform4fv (location, v.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform4fv (location, v);
		#end
		
	}
	
	
	public function uniform4i (location:GLUniformLocation, x:Int, y:Int, z:Int, w:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform4i (location, x, y, z, w);
		#end
		
	}
	
	
	public function uniform4iv (location:GLUniformLocation, v:Int32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform4iv (location, v.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform4iv (location, v);
		#end
		
	}
	
	
	public function uniformMatrix2fv (location:GLUniformLocation, transpose:Bool, v:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform_matrix (location, transpose, v.buffer, 2);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform_matrix (location, transpose, v, 2);
		#end
		
	}
	
	
	public function uniformMatrix3fv (location:GLUniformLocation, transpose:Bool, v:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform_matrix (location, transpose, v.buffer, 3);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform_matrix (location, transpose, v, 3);
		#end
		
	}
	
	
	public function uniformMatrix4fv (location:GLUniformLocation, transpose:Bool, v:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform_matrix (location, transpose, v.buffer, 4);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_uniform_matrix (location, transpose, v, 4);
		#end
		
	}
	
	
	public function useProgram (program:GLProgram):Void {
		
		__currentProgram = program;
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_use_program (program);
		#end
		
	}
	
	
	public function validateProgram (program:GLProgram):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_validate_program (program);
		#end
		
	}
	
	
	public function vertexAttrib1f (indx:Int, x:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib1f (indx, x);
		#end
		
	}
	
	
	public function vertexAttrib1fv (indx:Int, values:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib1fv (indx, values.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib1fv (indx, values);
		#end
		
	}
	
	
	public function vertexAttrib2f (indx:Int, x:Float, y:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib2f (indx, x, y);
		#end
		
	}
	
	
	public function vertexAttrib2fv (indx:Int, values:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib2fv (indx, values.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib2fv (indx, values);
		#end
		
	}
	
	
	public function vertexAttrib3f (indx:Int, x:Float, y:Float, z:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib3f (indx, x, y, z);
		#end
		
	}
	
	
	public function vertexAttrib3fv (indx:Int, values:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib3fv (indx, values.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib3fv (indx, values);
		#end
		
	}
	
	
	public function vertexAttrib4f (indx:Int, x:Float, y:Float, z:Float, w:Float):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib4f (indx, x, y, z, w);
		#end
		
	}
	
	
	public function vertexAttrib4fv (indx:Int, values:Float32Array):Void {
		
		#if (lime_cffi && !nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib4fv (indx, values.buffer);
		#elseif (nodejs && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib4fv (indx, values);
		#end
		
	}
	
	
	public function vertexAttribPointer (indx:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:DataPointer):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_vertex_attrib_pointer (indx, size, type, normalized, stride, offset);
		#end
		
	}
	
	
	public function viewport (x:Int, y:Int, width:Int, height:Int):Void {
		
		#if (lime_cffi && lime_opengl && !macro)
		NativeCFFI.lime_gl_viewport (x, y, width, height);
		#end
		
	}
	
	
	private function __contextLost ():Void {
		
		__isContextLost = true;
		__arrayBufferBinding = null;
		__elementBufferBinding = null;
		__currentProgram = null;
		__framebufferBinding = null;
		__renderbufferBinding = null;
		__texture2DBinding = null;
		__textureCubeMapBinding = null;
		
	}
	
	
	private function __initialize ():Void {
		
		if (!__initialized) {
			
			__extensionObjectTypes["AMD_compressed_3DC_texture"] = AMD_compressed_3DC_texture;
			__extensionObjectTypes["AMD_compressed_ATC_texture"] = AMD_compressed_ATC_texture;
			__extensionObjectTypes["AMD_performance_monitor"] = AMD_performance_monitor;
			__extensionObjectTypes["AMD_program_binary_Z400"] = AMD_program_binary_Z400;
			__extensionObjectTypes["ANGLE_framebuffer_blit"] = ANGLE_framebuffer_blit;
			__extensionObjectTypes["ANGLE_framebuffer_multisample"] = ANGLE_framebuffer_multisample;
			__extensionObjectTypes["ANGLE_instanced_arrays"] = ANGLE_instanced_arrays;
			__extensionObjectTypes["ANGLE_pack_reverse_row_order"] = ANGLE_pack_reverse_row_order;
			__extensionObjectTypes["ANGLE_texture_compression_dxt3"] = ANGLE_texture_compression_dxt3;
			__extensionObjectTypes["ANGLE_texture_compression_dxt5"] = ANGLE_texture_compression_dxt5;
			__extensionObjectTypes["ANGLE_texture_usage"] = ANGLE_texture_usage;
			__extensionObjectTypes["ANGLE_translated_shader_source"] = ANGLE_translated_shader_source;
			__extensionObjectTypes["APPLE_copy_texture_levels"] = APPLE_copy_texture_levels;
			__extensionObjectTypes["APPLE_framebuffer_multisample"] = APPLE_framebuffer_multisample;
			__extensionObjectTypes["APPLE_rgb_422"] = APPLE_rgb_422;
			__extensionObjectTypes["APPLE_sync"] = APPLE_sync;
			__extensionObjectTypes["APPLE_texture_format_BGRA8888"] = APPLE_texture_format_BGRA8888;
			__extensionObjectTypes["APPLE_texture_max_level"] = APPLE_texture_max_level;
			__extensionObjectTypes["ARM_mali_program_binary"] = ARM_mali_program_binary;
			__extensionObjectTypes["ARM_mali_shader_binary"] = ARM_mali_shader_binary;
			__extensionObjectTypes["ARM_rgba8"] = ARM_rgba8;
			__extensionObjectTypes["DMP_shader_binary"] = DMP_shader_binary;
			__extensionObjectTypes["EXT_bgra"] = EXT_bgra;
			__extensionObjectTypes["EXT_blend_minmax"] = EXT_blend_minmax;
			__extensionObjectTypes["EXT_color_buffer_float"] = EXT_color_buffer_float;
			__extensionObjectTypes["EXT_color_buffer_half_float"] = EXT_color_buffer_half_float;
			__extensionObjectTypes["EXT_debug_label"] = EXT_debug_label;
			__extensionObjectTypes["EXT_debug_marker"] = EXT_debug_marker;
			__extensionObjectTypes["EXT_discard_framebuffer"] = EXT_discard_framebuffer;
			__extensionObjectTypes["EXT_map_buffer_range"] = EXT_map_buffer_range;
			__extensionObjectTypes["EXT_multi_draw_arrays"] = EXT_multi_draw_arrays;
			__extensionObjectTypes["EXT_multisampled_render_to_texture"] = EXT_multisampled_render_to_texture;
			__extensionObjectTypes["EXT_multiview_draw_buffers"] = EXT_multiview_draw_buffers;
			__extensionObjectTypes["EXT_occlusion_query_boolean"] = EXT_occlusion_query_boolean;
			__extensionObjectTypes["EXT_read_format_bgra"] = EXT_read_format_bgra;
			__extensionObjectTypes["EXT_robustness"] = EXT_robustness;
			__extensionObjectTypes["EXT_sRGB"] = EXT_sRGB;
			__extensionObjectTypes["EXT_separate_shader_objects"] = EXT_separate_shader_objects;
			__extensionObjectTypes["EXT_shader_framebuffer_fetch"] = EXT_shader_framebuffer_fetch;
			__extensionObjectTypes["EXT_shader_texture_lod"] = EXT_shader_texture_lod;
			__extensionObjectTypes["EXT_shadow_samplers"] = EXT_shadow_samplers;
			__extensionObjectTypes["EXT_texture_compression_dxt1"] = EXT_texture_compression_dxt1;
			__extensionObjectTypes["EXT_texture_filter_anisotropic"] = EXT_texture_filter_anisotropic;
			__extensionObjectTypes["EXT_texture_format_BGRA8888"] = EXT_texture_format_BGRA8888;
			__extensionObjectTypes["EXT_texture_rg"] = EXT_texture_rg;
			__extensionObjectTypes["EXT_texture_storage"] = EXT_texture_storage;
			__extensionObjectTypes["EXT_texture_type_2_10_10_10_REV"] = EXT_texture_type_2_10_10_10_REV;
			__extensionObjectTypes["EXT_unpack_subimage"] = EXT_unpack_subimage;
			__extensionObjectTypes["FJ_shader_binary_GCCSO"] = FJ_shader_binary_GCCSO;
			__extensionObjectTypes["IMG_multisampled_render_to_texture"] = IMG_multisampled_render_to_texture;
			__extensionObjectTypes["IMG_program_binary"] = IMG_program_binary;
			__extensionObjectTypes["IMG_read_format"] = IMG_read_format;
			__extensionObjectTypes["IMG_shader_binary"] = IMG_shader_binary;
			__extensionObjectTypes["IMG_texture_compression_pvrtc"] = IMG_texture_compression_pvrtc;
			__extensionObjectTypes["KHR_debug"] = KHR_debug;
			__extensionObjectTypes["KHR_texture_compression_astc_ldr"] = KHR_texture_compression_astc_ldr;
			__extensionObjectTypes["NV_coverage_sample"] = NV_coverage_sample;
			__extensionObjectTypes["NV_depth_nonlinear"] = NV_depth_nonlinear;
			__extensionObjectTypes["NV_draw_buffers"] = NV_draw_buffers;
			__extensionObjectTypes["NV_fbo_color_attachments"] = NV_fbo_color_attachments;
			__extensionObjectTypes["NV_fence"] = NV_fence;
			__extensionObjectTypes["NV_read_buffer"] = NV_read_buffer;
			__extensionObjectTypes["NV_read_buffer_front"] = NV_read_buffer_front;
			__extensionObjectTypes["NV_read_depth"] = NV_read_depth;
			__extensionObjectTypes["NV_read_depth_stencil"] = NV_read_depth_stencil;
			__extensionObjectTypes["NV_read_stencil"] = NV_read_stencil;
			__extensionObjectTypes["NV_texture_compression_s3tc_update"] = NV_texture_compression_s3tc_update;
			__extensionObjectTypes["NV_texture_npot_2D_mipmap"] = NV_texture_npot_2D_mipmap;
			__extensionObjectTypes["OES_EGL_image"] = OES_EGL_image;
			__extensionObjectTypes["OES_EGL_image_external"] = OES_EGL_image_external;
			__extensionObjectTypes["OES_compressed_ETC1_RGB8_texture"] = OES_compressed_ETC1_RGB8_texture;
			__extensionObjectTypes["OES_compressed_paletted_texture"] = OES_compressed_paletted_texture;
			__extensionObjectTypes["OES_depth24"] = OES_depth24;
			__extensionObjectTypes["OES_depth32"] = OES_depth32;
			__extensionObjectTypes["OES_depth_texture"] = OES_depth_texture;
			__extensionObjectTypes["OES_element_index_uint"] = OES_element_index_uint;
			__extensionObjectTypes["OES_get_program_binary"] = OES_get_program_binary;
			__extensionObjectTypes["OES_mapbuffer"] = OES_mapbuffer;
			__extensionObjectTypes["OES_packed_depth_stencil"] = OES_packed_depth_stencil;
			__extensionObjectTypes["OES_required_internalformat"] = OES_required_internalformat;
			__extensionObjectTypes["OES_rgb8_rgba8"] = OES_rgb8_rgba8;
			__extensionObjectTypes["OES_standard_derivatives"] = OES_standard_derivatives;
			__extensionObjectTypes["OES_stencil1"] = OES_stencil1;
			__extensionObjectTypes["OES_stencil4"] = OES_stencil4;
			__extensionObjectTypes["OES_surfaceless_context"] = OES_surfaceless_context;
			__extensionObjectTypes["OES_texture_3D"] = OES_texture_3D;
			__extensionObjectTypes["OES_texture_float"] = OES_texture_float;
			__extensionObjectTypes["OES_texture_float_linear"] = OES_texture_float_linear;
			__extensionObjectTypes["OES_texture_half_float"] = OES_texture_half_float;
			__extensionObjectTypes["OES_texture_half_float_linear"] = OES_texture_half_float_linear;
			__extensionObjectTypes["OES_texture_npot"] = OES_texture_npot;
			__extensionObjectTypes["OES_vertex_array_object"] = OES_vertex_array_object;
			__extensionObjectTypes["OES_vertex_half_float"] = OES_vertex_half_float;
			__extensionObjectTypes["OES_vertex_type_10_10_10_2"] = OES_vertex_type_10_10_10_2;
			__extensionObjectTypes["QCOM_alpha_test"] = QCOM_alpha_test;
			__extensionObjectTypes["QCOM_binning_control"] = QCOM_binning_control;
			__extensionObjectTypes["QCOM_driver_control"] = QCOM_driver_control;
			__extensionObjectTypes["QCOM_extended_get"] = QCOM_extended_get;
			__extensionObjectTypes["QCOM_extended_get2"] = QCOM_extended_get2;
			__extensionObjectTypes["QCOM_perfmon_global_mode"] = QCOM_perfmon_global_mode;
			__extensionObjectTypes["QCOM_tiled_rendering"] = QCOM_tiled_rendering;
			__extensionObjectTypes["QCOM_writeonly_rendering"] = QCOM_writeonly_rendering;
			__extensionObjectTypes["VIV_shader_binary"] = VIV_shader_binary;
			
			#if (lime_cffi && lime_opengl && !macro)
			NativeCFFI.lime_gl_object_constructor (GLObjectType.PROGRAM, function (id) return new GLProgram (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.SHADER, function (id) return new GLShader (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.BUFFER, function (id) return new GLBuffer (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.TEXTURE, function (id) return new GLTexture (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.FRAMEBUFFER, function (id) return new GLFramebuffer (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.RENDERBUFFER, function (id) return new GLRenderbuffer (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.VERTEX_ARRAY_OBJECT, function (id) return new GLVertexArrayObject (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.QUERY, function (id) return new GLQuery (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.SAMPLER, function (id) return new GLSampler (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.SYNC, function (id) return new GLSync (id));
			NativeCFFI.lime_gl_object_constructor (GLObjectType.TRANSFORM_FEEDBACK, function (id) return new GLTransformFeedback (id));
			#end
			
		}
		
		__initialized = true;
		
	}
	
	
}


@:enum private abstract GLObjectType(Int) to Int {
	
	var PROGRAM = 0;
	var SHADER = 1;
	var BUFFER = 2;
	var TEXTURE = 3;
	var FRAMEBUFFER = 4;
	var RENDERBUFFER = 5;
	var VERTEX_ARRAY_OBJECT = 6;
	var QUERY = 7;
	var SAMPLER = 8;
	var SYNC = 9;
	var TRANSFORM_FEEDBACK = 10;
	
}