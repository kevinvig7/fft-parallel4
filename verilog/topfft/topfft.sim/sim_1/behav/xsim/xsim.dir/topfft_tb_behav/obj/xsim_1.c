/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_2(char*, char *);
extern void execute_166(char*, char *);
extern void execute_167(char*, char *);
extern void execute_168(char*, char *);
extern void execute_169(char*, char *);
extern void execute_429(char*, char *);
extern void execute_430(char*, char *);
extern void execute_431(char*, char *);
extern void execute_432(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_178(char*, char *);
extern void execute_207(char*, char *);
extern void execute_420(char*, char *);
extern void execute_421(char*, char *);
extern void execute_422(char*, char *);
extern void execute_423(char*, char *);
extern void execute_424(char*, char *);
extern void execute_425(char*, char *);
extern void execute_426(char*, char *);
extern void execute_427(char*, char *);
extern void execute_428(char*, char *);
extern void execute_5(char*, char *);
extern void execute_7(char*, char *);
extern void execute_9(char*, char *);
extern void execute_15(char*, char *);
extern void execute_179(char*, char *);
extern void execute_14(char*, char *);
extern void execute_19(char*, char *);
extern void execute_180(char*, char *);
extern void execute_18(char*, char *);
extern void execute_23(char*, char *);
extern void execute_181(char*, char *);
extern void execute_22(char*, char *);
extern void execute_27(char*, char *);
extern void execute_182(char*, char *);
extern void execute_26(char*, char *);
extern void execute_31(char*, char *);
extern void execute_183(char*, char *);
extern void execute_30(char*, char *);
extern void execute_184(char*, char *);
extern void execute_185(char*, char *);
extern void execute_186(char*, char *);
extern void execute_187(char*, char *);
extern void execute_188(char*, char *);
extern void execute_189(char*, char *);
extern void execute_34(char*, char *);
extern void execute_190(char*, char *);
extern void execute_191(char*, char *);
extern void execute_192(char*, char *);
extern void execute_193(char*, char *);
extern void execute_194(char*, char *);
extern void execute_195(char*, char *);
extern void execute_196(char*, char *);
extern void execute_197(char*, char *);
extern void execute_198(char*, char *);
extern void execute_199(char*, char *);
extern void execute_200(char*, char *);
extern void execute_201(char*, char *);
extern void execute_202(char*, char *);
extern void execute_203(char*, char *);
extern void execute_204(char*, char *);
extern void execute_205(char*, char *);
extern void execute_206(char*, char *);
extern void execute_208(char*, char *);
extern void execute_209(char*, char *);
extern void execute_210(char*, char *);
extern void execute_211(char*, char *);
extern void execute_212(char*, char *);
extern void execute_213(char*, char *);
extern void execute_214(char*, char *);
extern void execute_215(char*, char *);
extern void execute_216(char*, char *);
extern void execute_217(char*, char *);
extern void execute_218(char*, char *);
extern void execute_219(char*, char *);
extern void execute_238(char*, char *);
extern void execute_239(char*, char *);
extern void execute_280(char*, char *);
extern void execute_281(char*, char *);
extern void execute_242(char*, char *);
extern void execute_243(char*, char *);
extern void execute_252(char*, char *);
extern void execute_253(char*, char *);
extern void execute_254(char*, char *);
extern void execute_255(char*, char *);
extern void execute_77(char*, char *);
extern void execute_244(char*, char *);
extern void execute_245(char*, char *);
extern void execute_85(char*, char *);
extern void execute_86(char*, char *);
extern void execute_270(char*, char *);
extern void execute_271(char*, char *);
extern void execute_272(char*, char *);
extern void execute_273(char*, char *);
extern void execute_274(char*, char *);
extern void execute_275(char*, char *);
extern void execute_276(char*, char *);
extern void execute_277(char*, char *);
extern void execute_278(char*, char *);
extern void execute_279(char*, char *);
extern void execute_282(char*, char *);
extern void execute_283(char*, char *);
extern void vlog_simple_process_execute_1_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_312(char*, char *);
extern void execute_313(char*, char *);
extern void execute_286(char*, char *);
extern void execute_287(char*, char *);
extern void execute_292(char*, char *);
extern void execute_293(char*, char *);
extern void execute_100(char*, char *);
extern void execute_288(char*, char *);
extern void execute_289(char*, char *);
extern void execute_104(char*, char *);
extern void execute_105(char*, char *);
extern void execute_302(char*, char *);
extern void execute_303(char*, char *);
extern void execute_304(char*, char *);
extern void execute_305(char*, char *);
extern void execute_306(char*, char *);
extern void execute_307(char*, char *);
extern void execute_308(char*, char *);
extern void execute_309(char*, char *);
extern void execute_310(char*, char *);
extern void execute_311(char*, char *);
extern void execute_314(char*, char *);
extern void execute_315(char*, char *);
extern void execute_338(char*, char *);
extern void execute_339(char*, char *);
extern void execute_318(char*, char *);
extern void execute_319(char*, char *);
extern void execute_322(char*, char *);
extern void execute_340(char*, char *);
extern void execute_341(char*, char *);
extern void execute_382(char*, char *);
extern void execute_383(char*, char *);
extern void execute_344(char*, char *);
extern void execute_345(char*, char *);
extern void execute_354(char*, char *);
extern void execute_355(char*, char *);
extern void execute_356(char*, char *);
extern void execute_357(char*, char *);
extern void execute_384(char*, char *);
extern void execute_385(char*, char *);
extern void execute_390(char*, char *);
extern void execute_391(char*, char *);
extern void execute_392(char*, char *);
extern void execute_148(char*, char *);
extern void execute_386(char*, char *);
extern void execute_387(char*, char *);
extern void execute_402(char*, char *);
extern void execute_403(char*, char *);
extern void execute_408(char*, char *);
extern void execute_409(char*, char *);
extern void execute_410(char*, char *);
extern void execute_158(char*, char *);
extern void execute_404(char*, char *);
extern void execute_405(char*, char *);
extern void execute_171(char*, char *);
extern void execute_172(char*, char *);
extern void execute_173(char*, char *);
extern void execute_433(char*, char *);
extern void execute_434(char*, char *);
extern void execute_435(char*, char *);
extern void execute_436(char*, char *);
extern void execute_437(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[166] = {(funcp)execute_2, (funcp)execute_166, (funcp)execute_167, (funcp)execute_168, (funcp)execute_169, (funcp)execute_429, (funcp)execute_430, (funcp)execute_431, (funcp)execute_432, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_178, (funcp)execute_207, (funcp)execute_420, (funcp)execute_421, (funcp)execute_422, (funcp)execute_423, (funcp)execute_424, (funcp)execute_425, (funcp)execute_426, (funcp)execute_427, (funcp)execute_428, (funcp)execute_5, (funcp)execute_7, (funcp)execute_9, (funcp)execute_15, (funcp)execute_179, (funcp)execute_14, (funcp)execute_19, (funcp)execute_180, (funcp)execute_18, (funcp)execute_23, (funcp)execute_181, (funcp)execute_22, (funcp)execute_27, (funcp)execute_182, (funcp)execute_26, (funcp)execute_31, (funcp)execute_183, (funcp)execute_30, (funcp)execute_184, (funcp)execute_185, (funcp)execute_186, (funcp)execute_187, (funcp)execute_188, (funcp)execute_189, (funcp)execute_34, (funcp)execute_190, (funcp)execute_191, (funcp)execute_192, (funcp)execute_193, (funcp)execute_194, (funcp)execute_195, (funcp)execute_196, (funcp)execute_197, (funcp)execute_198, (funcp)execute_199, (funcp)execute_200, (funcp)execute_201, (funcp)execute_202, (funcp)execute_203, (funcp)execute_204, (funcp)execute_205, (funcp)execute_206, (funcp)execute_208, (funcp)execute_209, (funcp)execute_210, (funcp)execute_211, (funcp)execute_212, (funcp)execute_213, (funcp)execute_214, (funcp)execute_215, (funcp)execute_216, (funcp)execute_217, (funcp)execute_218, (funcp)execute_219, (funcp)execute_238, (funcp)execute_239, (funcp)execute_280, (funcp)execute_281, (funcp)execute_242, (funcp)execute_243, (funcp)execute_252, (funcp)execute_253, (funcp)execute_254, (funcp)execute_255, (funcp)execute_77, (funcp)execute_244, (funcp)execute_245, (funcp)execute_85, (funcp)execute_86, (funcp)execute_270, (funcp)execute_271, (funcp)execute_272, (funcp)execute_273, (funcp)execute_274, (funcp)execute_275, (funcp)execute_276, (funcp)execute_277, (funcp)execute_278, (funcp)execute_279, (funcp)execute_282, (funcp)execute_283, (funcp)vlog_simple_process_execute_1_fast_no_reg_no_agg, (funcp)execute_312, (funcp)execute_313, (funcp)execute_286, (funcp)execute_287, (funcp)execute_292, (funcp)execute_293, (funcp)execute_100, (funcp)execute_288, (funcp)execute_289, (funcp)execute_104, (funcp)execute_105, (funcp)execute_302, (funcp)execute_303, (funcp)execute_304, (funcp)execute_305, (funcp)execute_306, (funcp)execute_307, (funcp)execute_308, (funcp)execute_309, (funcp)execute_310, (funcp)execute_311, (funcp)execute_314, (funcp)execute_315, (funcp)execute_338, (funcp)execute_339, (funcp)execute_318, (funcp)execute_319, (funcp)execute_322, (funcp)execute_340, (funcp)execute_341, (funcp)execute_382, (funcp)execute_383, (funcp)execute_344, (funcp)execute_345, (funcp)execute_354, (funcp)execute_355, (funcp)execute_356, (funcp)execute_357, (funcp)execute_384, (funcp)execute_385, (funcp)execute_390, (funcp)execute_391, (funcp)execute_392, (funcp)execute_148, (funcp)execute_386, (funcp)execute_387, (funcp)execute_402, (funcp)execute_403, (funcp)execute_408, (funcp)execute_409, (funcp)execute_410, (funcp)execute_158, (funcp)execute_404, (funcp)execute_405, (funcp)execute_171, (funcp)execute_172, (funcp)execute_173, (funcp)execute_433, (funcp)execute_434, (funcp)execute_435, (funcp)execute_436, (funcp)execute_437, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 166;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/topfft_tb_behav/xsim.reloc",  (void **)funcTab, 166);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/topfft_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/topfft_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/topfft_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/topfft_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/topfft_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
