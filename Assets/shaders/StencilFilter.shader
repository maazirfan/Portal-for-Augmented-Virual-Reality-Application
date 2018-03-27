Shader "Custom/StencilFilter"
{
	Properties
	{
		_Color ("Color",Color) = (1,1,1,1)
		//use below code for debugging and manually setting stencil test
		[Enum(Equal,3,NotEqual,6)] _StencilTest ("Stencil Test" ,int) = 6
	}
	SubShader
	{

	Color [_Color]
	Stencil {
	Ref 1
	Comp [_StencilTest]
	}



		Pass
		{
			
		}
	}
}
