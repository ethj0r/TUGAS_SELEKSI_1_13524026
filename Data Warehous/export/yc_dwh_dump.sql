--
-- PostgreSQL database dump
--

\restrict 6AWkg7fPsQifnR4hy6tTL05NG3awN0d1pKxoEdgo3BH8Rh8Eby7UhxasxbCIST9

-- Dumped from database version 16.14 (Homebrew)
-- Dumped by pg_dump version 16.14 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bridgecompanyindustry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bridgecompanyindustry (
    company_key integer NOT NULL,
    industry_key integer NOT NULL
);


--
-- Name: dimbatch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dimbatch (
    batch_key integer NOT NULL,
    batch_id character varying(6) NOT NULL,
    season character varying(10) NOT NULL,
    year integer NOT NULL,
    quarter character(2) NOT NULL
);


--
-- Name: dimbatch_batch_key_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dimbatch_batch_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dimbatch_batch_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dimbatch_batch_key_seq OWNED BY public.dimbatch.batch_key;


--
-- Name: dimindustry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dimindustry (
    industry_key integer NOT NULL,
    industry_name character varying(80) NOT NULL
);


--
-- Name: dimindustry_industry_key_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dimindustry_industry_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dimindustry_industry_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dimindustry_industry_key_seq OWNED BY public.dimindustry.industry_key;


--
-- Name: dimlocation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dimlocation (
    location_key integer NOT NULL,
    city character varying(80),
    state character varying(80),
    country character varying(80)
);


--
-- Name: dimlocation_location_key_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dimlocation_location_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dimlocation_location_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dimlocation_location_key_seq OWNED BY public.dimlocation.location_key;


--
-- Name: dimstatus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dimstatus (
    status_key integer NOT NULL,
    status_name character varying(20) NOT NULL
);


--
-- Name: dimstatus_status_key_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dimstatus_status_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dimstatus_status_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dimstatus_status_key_seq OWNED BY public.dimstatus.status_key;


--
-- Name: factcompany; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.factcompany (
    company_key integer NOT NULL,
    slug character varying(60) NOT NULL,
    batch_key integer,
    location_key integer,
    status_key integer NOT NULL,
    team_size integer,
    company_age integer,
    founder_count integer NOT NULL,
    industry_count integer NOT NULL
);


--
-- Name: factcompany_company_key_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.factcompany_company_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: factcompany_company_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.factcompany_company_key_seq OWNED BY public.factcompany.company_key;


--
-- Name: factfounder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.factfounder (
    founder_key integer NOT NULL,
    founder_name character varying(80) NOT NULL,
    company_slug character varying(60) NOT NULL,
    batch_key integer,
    location_key integer,
    status_key integer NOT NULL,
    social_count integer NOT NULL,
    linkedin_count integer NOT NULL,
    twitter_count integer NOT NULL,
    github_count integer NOT NULL
);


--
-- Name: factfounder_founder_key_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.factfounder_founder_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: factfounder_founder_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.factfounder_founder_key_seq OWNED BY public.factfounder.founder_key;


--
-- Name: dimbatch batch_key; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimbatch ALTER COLUMN batch_key SET DEFAULT nextval('public.dimbatch_batch_key_seq'::regclass);


--
-- Name: dimindustry industry_key; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimindustry ALTER COLUMN industry_key SET DEFAULT nextval('public.dimindustry_industry_key_seq'::regclass);


--
-- Name: dimlocation location_key; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimlocation ALTER COLUMN location_key SET DEFAULT nextval('public.dimlocation_location_key_seq'::regclass);


--
-- Name: dimstatus status_key; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimstatus ALTER COLUMN status_key SET DEFAULT nextval('public.dimstatus_status_key_seq'::regclass);


--
-- Name: factcompany company_key; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factcompany ALTER COLUMN company_key SET DEFAULT nextval('public.factcompany_company_key_seq'::regclass);


--
-- Name: factfounder founder_key; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factfounder ALTER COLUMN founder_key SET DEFAULT nextval('public.factfounder_founder_key_seq'::regclass);


--
-- Data for Name: bridgecompanyindustry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bridgecompanyindustry (company_key, industry_key) FROM stdin;
241	1
241	2
21	1
21	3
190	4
190	5
353	4
353	6
404	1
404	2
515	7
515	8
588	9
588	10
733	9
733	11
334	7
334	12
104	13
104	14
247	7
247	15
268	16
268	17
507	1
507	18
42	7
42	19
623	7
623	12
961	7
961	20
333	13
333	21
634	13
634	22
543	9
543	23
262	9
262	24
480	13
480	14
778	7
778	19
31	7
31	12
906	4
906	25
915	1
915	26
665	16
665	17
100	1
100	27
216	9
216	24
101	7
146	7
146	28
106	7
106	12
118	4
118	5
883	1
883	26
182	29
159	7
159	30
461	7
461	31
177	1
361	7
361	19
783	4
783	32
223	7
223	33
174	29
137	7
137	8
718	1
718	26
288	7
288	8
487	1
487	34
280	7
280	8
289	7
289	35
608	7
608	12
293	7
293	36
965	4
965	32
963	7
963	37
298	7
298	12
832	7
832	38
581	13
581	39
341	7
341	30
207	7
207	35
98	9
98	40
342	1
342	41
368	7
368	35
354	7
354	36
364	7
364	15
983	7
983	30
357	7
357	30
377	1
377	41
541	13
541	39
188	7
188	12
599	4
533	7
533	19
644	4
644	32
550	9
550	10
244	13
244	42
589	1
589	34
564	4
564	43
572	1
572	18
576	7
576	36
586	7
335	7
335	12
696	1
696	27
321	4
321	25
675	7
675	8
706	1
706	2
708	4
708	32
736	7
736	30
767	7
767	12
768	1
768	41
776	1
776	26
793	7
793	36
810	4
810	25
844	4
958	4
958	32
962	7
962	37
967	1
977	7
977	15
988	1
988	2
306	7
306	8
529	7
529	12
219	7
219	15
654	1
654	27
618	29
505	7
492	1
492	44
898	1
898	45
418	13
418	46
329	7
329	47
158	7
158	12
974	7
974	33
343	4
343	25
839	7
839	31
225	7
225	12
822	1
822	27
452	7
452	30
555	7
555	35
383	7
383	30
297	9
297	48
257	1
257	45
406	7
406	31
186	13
186	14
107	7
107	35
881	13
881	42
888	1
888	3
307	7
307	12
6	49
972	4
972	32
799	1
799	26
789	1
789	27
717	4
717	25
666	4
666	32
659	9
659	40
313	7
313	31
522	13
522	39
987	7
987	12
500	1
500	41
164	13
164	39
336	29
245	4
153	1
153	2
173	7
173	28
112	13
112	39
942	13
942	22
892	9
892	40
879	7
879	33
18	13
18	42
709	9
709	10
848	9
848	50
197	7
197	51
116	7
116	8
367	1
367	34
814	7
814	12
638	7
638	37
73	7
73	36
323	7
323	20
563	16
416	7
416	28
457	49
866	7
866	30
870	7
870	35
482	1
482	45
790	13
790	22
504	7
504	8
566	13
566	39
700	13
700	42
724	1
724	26
863	7
863	15
296	1
296	41
971	13
971	14
984	13
984	46
858	1
858	3
842	7
842	47
513	7
513	8
460	1
460	45
397	13
397	21
337	7
337	33
252	7
252	37
699	16
699	52
171	1
171	45
725	16
725	17
494	7
494	37
867	7
867	15
872	13
872	39
806	49
758	7
758	12
711	7
711	12
125	16
125	52
667	7
667	15
446	1
446	2
338	1
338	45
94	4
94	5
981	9
981	48
887	49
229	49
594	7
594	37
580	13
580	22
121	9
121	10
491	7
521	7
521	35
24	13
24	42
702	13
702	42
96	49
363	9
363	10
358	7
358	31
317	7
317	15
50	7
50	35
746	1
746	3
375	7
375	37
829	1
829	44
929	7
929	47
788	4
788	5
660	13
650	7
650	37
29	9
29	11
551	1
551	41
520	13
520	42
692	7
692	35
351	1
351	27
388	1
388	34
291	1
291	2
172	4
172	25
93	1
93	45
394	49
249	7
249	37
598	49
532	1
322	9
322	50
992	7
992	8
991	4
991	53
907	7
355	16
355	52
813	16
813	52
514	13
514	54
795	1
795	3
697	1
697	45
682	7
682	12
661	7
661	20
591	49
512	1
512	41
261	7
261	15
184	49
183	29
568	13
135	29
53	1
53	45
141	13
38	7
38	47
23	1
23	3
3	7
3	8
905	4
719	1
719	45
472	7
472	37
631	29
213	7
213	8
269	7
269	36
251	7
251	36
74	7
646	9
5	13
5	54
957	13
346	1
346	2
966	1
966	45
964	4
964	6
804	13
804	54
165	9
165	11
276	13
276	54
703	7
703	8
477	1
477	41
843	7
843	37
399	7
399	35
270	7
270	35
160	7
160	8
455	1
455	45
622	7
622	15
126	1
126	45
166	7
166	12
846	1
846	41
9	1
9	55
854	1
854	26
672	7
242	7
242	15
934	1
934	41
295	7
295	51
92	7
92	47
847	7
565	1
565	26
584	7
584	30
924	7
924	51
259	13
259	42
320	4
320	6
985	7
985	36
506	7
506	15
360	13
360	54
382	13
382	42
552	7
552	37
704	7
704	12
774	7
774	15
130	4
130	25
947	7
947	35
200	7
803	7
803	12
275	7
275	35
254	7
254	35
180	7
615	7
615	15
759	9
759	11
744	9
744	11
593	7
593	38
43	7
43	51
655	7
423	7
301	4
250	9
250	56
378	9
378	56
602	7
602	12
389	7
389	12
809	9
809	23
7	9
530	7
530	35
462	4
684	9
140	13
19	7
19	19
15	4
694	9
694	11
400	7
400	35
607	9
210	9
502	7
502	35
231	13
231	42
417	9
417	56
945	16
945	52
451	7
739	4
739	43
279	7
279	38
968	7
968	36
110	1
110	34
352	9
352	56
596	7
569	9
569	11
4	9
4	11
108	29
488	7
488	35
861	7
861	31
302	16
302	17
542	9
542	40
151	7
227	7
227	35
32	7
32	12
775	7
775	15
897	7
897	35
181	7
181	35
202	7
202	35
339	7
339	15
908	7
33	16
33	17
232	7
232	35
712	16
712	52
356	9
356	56
300	13
737	9
737	50
940	57
408	13
459	7
827	7
827	35
917	7
917	35
747	7
747	51
688	7
688	12
731	7
731	33
994	7
559	7
559	38
904	7
633	7
633	35
647	7
605	1
379	4
379	25
175	29
630	7
630	8
895	9
734	7
734	35
25	7
373	1
735	7
735	35
385	4
385	43
891	7
189	7
189	33
499	9
499	56
409	9
409	11
170	7
170	38
314	13
59	13
59	54
669	1
669	34
265	7
386	7
386	15
402	7
402	12
714	7
540	7
540	51
629	13
629	54
150	16
150	52
442	7
442	35
436	4
436	43
303	7
332	7
332	12
63	9
63	56
76	7
453	13
77	13
77	22
496	7
496	37
86	9
86	11
536	4
536	25
66	7
730	7
730	37
920	4
920	32
60	7
60	33
17	7
17	35
350	4
350	25
433	7
754	7
754	12
975	1
975	26
273	7
273	35
156	7
156	37
645	7
645	15
65	7
65	51
85	7
690	7
690	35
893	7
893	38
606	7
606	15
51	9
51	10
324	9
324	23
601	7
601	12
75	7
75	15
39	7
369	7
707	7
707	38
670	13
670	54
880	7
880	12
253	9
253	11
305	7
54	16
611	9
611	48
46	1
46	27
10	13
10	22
517	7
517	35
763	7
680	1
680	34
802	7
105	13
791	7
61	7
61	35
443	7
443	37
956	7
956	35
864	7
864	15
162	7
954	7
954	51
67	9
67	11
821	4
821	6
64	7
64	12
664	16
990	7
990	35
55	7
55	15
931	4
931	5
325	7
325	35
865	7
865	37
221	7
221	19
525	7
525	35
228	9
228	48
58	4
58	32
741	4
812	7
812	35
34	4
34	32
753	13
28	7
28	36
192	7
192	8
20	9
20	56
398	13
398	21
547	4
547	43
927	7
727	1
882	7
882	51
693	9
693	11
484	13
484	46
12	13
12	14
765	7
765	15
431	7
950	13
585	7
585	12
595	7
595	51
556	1
345	7
345	47
445	7
102	7
448	7
448	12
432	4
432	6
834	7
834	35
859	13
859	54
624	7
134	7
134	51
855	9
855	11
246	7
246	35
62	7
44	7
44	28
722	1
722	58
403	7
403	37
760	7
760	47
792	7
930	7
930	15
899	7
899	36
838	7
838	31
798	9
798	11
490	9
490	10
641	7
641	37
698	7
224	7
428	4
428	6
370	4
960	4
960	6
260	7
410	7
410	35
993	4
993	53
422	13
422	39
434	4
434	43
347	57
851	7
851	12
344	7
469	7
469	35
466	1
380	7
380	35
873	9
873	56
79	7
79	12
903	7
903	51
884	7
222	7
222	36
401	9
401	11
982	7
982	12
45	7
45	36
567	9
567	11
396	7
161	7
757	7
757	31
236	9
468	7
468	12
916	9
916	11
772	7
372	7
372	36
625	7
750	16
750	17
723	7
723	12
896	4
896	25
970	7
614	7
405	7
516	7
516	37
648	7
835	7
835	12
837	4
837	6
687	7
687	35
440	7
437	13
437	42
853	9
853	56
362	4
362	43
911	7
969	7
503	7
503	12
471	7
471	31
196	9
196	10
721	1
794	7
794	35
959	7
959	35
918	4
918	32
143	7
237	9
237	23
910	7
80	7
80	12
290	7
290	47
609	9
616	7
616	35
995	7
740	13
740	42
679	7
677	7
677	36
831	4
831	25
681	7
952	7
535	7
535	51
211	13
936	7
850	7
850	15
862	7
203	9
205	4
205	53
913	1
913	58
136	7
136	12
349	4
801	7
801	15
508	7
508	35
538	7
538	35
889	7
889	35
99	7
99	38
282	7
282	28
412	7
412	35
833	9
833	10
215	7
308	16
114	7
206	7
206	12
326	7
326	28
311	1
311	27
330	7
330	33
258	4
258	6
157	7
340	7
340	12
582	7
582	33
240	1
785	4
465	9
465	10
238	13
238	22
786	9
786	11
852	7
852	12
562	7
562	19
951	9
951	10
678	7
57	7
57	35
124	7
124	51
674	1
131	7
201	7
201	19
766	7
766	35
518	7
90	9
90	23
620	7
620	35
142	7
142	47
762	7
381	9
381	11
312	4
807	7
807	37
743	7
743	15
726	7
263	7
263	15
413	7
199	9
928	7
928	12
932	4
932	25
8	9
8	56
52	7
52	12
900	7
729	7
511	4
511	5
283	4
283	5
264	7
264	33
154	7
154	35
72	7
640	13
640	42
948	7
948	12
856	7
856	12
777	9
777	56
421	7
139	7
683	13
683	39
732	7
642	1
642	34
371	7
371	38
454	7
454	19
876	7
876	35
619	7
133	7
695	4
695	53
407	4
840	7
919	7
919	15
123	7
123	35
194	7
194	35
597	13
198	7
495	13
495	42
828	7
878	9
878	10
243	1
939	9
612	7
612	35
649	7
649	31
284	7
284	35
824	7
824	12
256	7
256	51
761	7
761	35
544	7
544	28
705	7
523	9
523	48
103	9
103	23
583	9
583	50
68	7
68	12
14	7
481	7
481	35
769	13
769	42
745	9
745	10
808	7
808	12
548	7
979	7
979	12
83	7
83	28
941	4
941	43
218	7
218	35
875	7
628	4
2	7
2	12
89	7
444	9
444	11
989	4
989	32
144	7
163	7
604	7
662	7
662	35
149	13
149	22
128	7
128	36
266	7
145	7
145	35
97	13
841	13
841	22
95	7
691	7
691	38
187	7
187	15
318	7
458	7
458	28
784	7
784	12
1	7
728	7
728	12
797	7
797	12
70	9
70	11
464	7
464	38
91	4
818	7
818	12
239	13
449	7
752	7
752	35
479	7
685	13
751	13
438	7
438	35
435	4
857	7
857	15
592	9
592	11
233	7
233	35
632	4
632	43
395	1
909	7
909	35
643	7
610	13
610	22
169	13
169	39
376	9
267	13
933	7
933	12
56	9
209	7
209	51
319	7
319	33
470	7
470	12
13	9
13	11
673	7
148	1
148	34
497	7
497	35
359	7
359	51
168	13
168	54
414	9
414	10
179	7
179	12
986	9
986	10
510	57
558	9
419	7
419	47
214	7
214	38
742	7
742	12
603	7
41	7
41	35
826	7
545	7
978	7
978	33
501	7
501	36
949	9
949	48
176	7
176	15
281	7
281	12
935	7
935	28
796	1
796	41
48	7
48	12
485	13
485	42
560	16
938	7
235	7
235	19
40	4
40	43
310	9
310	11
111	7
111	37
467	9
467	11
886	7
886	37
869	7
115	7
315	4
315	25
527	1
527	34
748	13
489	7
489	51
327	9
327	23
420	7
272	13
272	22
925	7
925	12
651	7
651	12
427	7
427	47
391	9
391	56
764	4
860	7
230	7
230	33
519	7
426	7
11	7
11	37
167	1
81	16
81	52
825	7
825	12
686	7
926	7
926	37
217	7
217	33
478	7
657	7
823	7
823	12
976	7
976	51
912	7
912	31
69	1
773	7
271	1
274	7
393	7
393	47
49	13
639	7
756	7
756	35
894	1
894	27
579	13
456	7
456	47
663	1
663	26
208	9
208	11
816	7
816	12
890	7
621	7
668	13
147	4
147	43
779	4
779	25
195	7
195	12
463	7
463	28
185	7
193	7
193	28
117	7
286	13
286	59
849	1
138	7
138	35
716	7
365	16
365	17
30	1
475	7
475	15
16	7
16	38
901	16
874	9
874	11
430	7
430	38
476	7
770	7
770	35
553	7
553	38
35	9
35	11
921	7
787	7
787	35
47	1
877	7
877	47
447	57
780	1
537	7
781	7
294	1
294	26
374	7
374	12
78	7
78	12
955	9
955	23
561	1
387	7
212	7
212	33
902	7
937	7
943	7
943	38
528	7
528	12
871	7
871	37
122	7
122	19
441	1
441	26
425	13
425	42
571	13
820	7
486	7
486	36
220	7
220	12
885	7
885	12
819	7
819	30
132	7
132	12
36	4
474	7
474	12
226	7
71	7
71	12
771	7
390	7
390	35
113	7
348	7
980	4
980	32
549	7
549	12
636	1
120	16
120	52
637	7
845	16
845	17
922	7
922	37
22	1
119	7
119	35
277	7
277	12
782	7
782	12
450	7
450	37
255	9
255	11
577	9
577	11
234	1
234	55
109	1
534	1
627	7
923	7
713	1
713	55
483	7
483	35
316	4
127	7
127	36
88	7
755	4
944	4
944	53
617	7
573	9
953	7
953	28
328	7
328	37
830	16
411	7
411	12
554	4
749	7
749	51
868	7
248	9
248	11
811	7
811	51
653	13
653	42
539	7
539	35
493	7
493	15
292	7
292	36
178	7
178	47
836	7
836	12
304	9
304	11
129	7
129	12
424	7
587	7
676	7
676	51
715	7
715	36
429	7
429	35
710	7
152	7
366	7
366	12
574	7
626	7
626	15
473	13
473	42
285	4
285	43
671	7
671	19
204	13
204	22
800	7
800	12
600	1
805	7
805	30
278	9
701	7
701	47
37	7
309	7
309	19
635	16
87	13
87	42
557	7
557	47
384	7
509	7
509	36
392	7
392	12
299	7
299	12
613	9
613	11
26	7
815	7
815	51
526	7
738	29
531	7
531	35
590	7
590	12
439	7
82	7
82	12
689	7
689	33
415	9
415	11
287	7
287	33
84	7
84	35
546	7
546	37
720	7
720	35
155	7
155	15
498	7
498	35
575	13
652	9
652	56
656	13
656	42
817	4
817	43
27	9
27	56
658	9
658	11
914	13
914	21
524	7
578	7
578	12
946	7
191	7
191	36
570	9
331	7
331	38
\.


--
-- Data for Name: dimbatch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dimbatch (batch_key, batch_id, season, year, quarter) FROM stdin;
1	Su13	Summer	2013	Q3
2	Wi09	Winter	2009	Q1
3	Su12	Summer	2012	Q3
4	Wi18	Winter	2018	Q1
5	Su16	Summer	2016	Q3
6	Su14	Summer	2014	Q3
7	Wi15	Winter	2015	Q1
8	Su17	Summer	2017	Q3
9	Su07	Summer	2007	Q3
10	Wi12	Winter	2012	Q1
11	Su10	Summer	2010	Q3
12	Wi14	Winter	2014	Q1
13	Su20	Summer	2020	Q3
14	Su18	Summer	2018	Q3
15	Wi16	Winter	2016	Q1
16	Su11	Summer	2011	Q3
17	Wi07	Winter	2007	Q1
18	Wi17	Winter	2017	Q1
19	Wi13	Winter	2013	Q1
20	Wi19	Winter	2019	Q1
21	Su05	Summer	2005	Q3
22	Wi11	Winter	2011	Q1
23	Wi08	Winter	2008	Q1
24	Wi10	Winter	2010	Q1
25	Su09	Summer	2009	Q3
26	Su15	Summer	2015	Q3
27	Wi21	Winter	2021	Q1
28	Su06	Summer	2006	Q3
29	Su19	Summer	2019	Q3
30	Wi20	Winter	2020	Q1
31	Su26	Summer	2026	Q3
32	Fa26	Fall	2026	Q4
33	Wi27	Winter	2027	Q1
34	Sp26	Spring	2026	Q2
35	Wi26	Winter	2026	Q1
36	Fa25	Fall	2025	Q4
37	Su25	Summer	2025	Q3
\.


--
-- Data for Name: dimindustry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dimindustry (industry_key, industry_name) FROM stdin;
1	Consumer
2	Food And Beverage
3	Travel, Leisure And Tourism
4	Fintech
5	Banking And Exchange
6	Asset Management
7	B2B
8	Retail
9	Industrials
10	Energy
11	Manufacturing And Robotics
12	Engineering, Product And Design
13	Healthcare
14	Diagnostics
15	Productivity
16	Real Estate And Construction
17	Construction
18	Virtual And Augmented Reality
19	Analytics
20	Office Management
21	Industrial Bio
22	Drug Discovery And Delivery
23	Aviation And Space
24	Automotive
25	Consumer Finance
26	Content
27	Consumer Electronics
28	Legal
29	Education
30	Human Resources
31	Recruiting And Talent
32	Payments
33	Finance And Accounting
34	Gaming
35	Infrastructure
36	Supply Chain And Logistics
37	Marketing
38	Security
39	Consumer Health And Wellness
40	Agriculture
41	Apparel And Cosmetics
42	Healthcare It
43	Insurance
44	Transportation Services
45	Home And Personal
46	Medical Devices
47	Sales
48	Drones
49	Unspecified
50	Climate
51	Operations
52	Housing And Real Estate
53	Credit And Lending
54	Healthcare Services
55	Social
56	Defense
57	Government
58	Job And Career Services
59	Therapeutics
\.


--
-- Data for Name: dimlocation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dimlocation (location_key, city, state, country) FROM stdin;
1	Akron	OH	USA
2	Amman	\N	Jordan
3	Amsterdam	\N	Netherlands
4	Amsterdam	NH	Netherlands
5	Atlanta	GA	USA
6	Austin	\N	TX
7	Austin	TX	USA
8	Austria	\N	\N
9	Bengaluru	KA	India
10	Bentonville	AR	USA
11	Berlin	\N	Germany
12	Berlin	Berlin	Germany
13	Blountville	TN	USA
14	Bogotá	Bogota	Colombia
15	Boston	MA	USA
16	Boulder	CO	USA
17	Brisbane	QLD	Australia
18	Brussels	Brussels	Belgium
19	CT	\N	Spain
20	Celje	Celje	Slovenia
21	Chattanooga	TN	USA
22	Chicago	IL	USA
23	Columbia	MD	USA
24	Columbia	MO	USA
25	Copenhagen	\N	Denmark
26	Dakar	Dakar Region	Senegal
27	Detroit	MI	USA
28	Dhaka	Dhaka Division	Bangladesh
29	Durango	CO	USA
30	Durham	NC	USA
31	El Segundo	CA	USA
32	Emeryville	CA	USA
33	Florida City	FL	USA
34	Germany	\N	\N
35	Gurugram	HR	India
36	Hong Kong	\N	Hong Kong
37	Honolulu	HI	USA
38	Jakarta	Jakarta	Indonesia
39	Kathmandu	Central Development Region	Nepal
40	Kitchener	ON	Canada
41	Kowloon	\N	Hong Kong
42	Kraków	Lesser Poland Voivodeship	Poland
43	Lagos	LA	Nigeria
44	Lehi	UT	USA
45	Lisbon	Lisbon	Portugal
46	Ljubljana	Ljubljana	Slovenia
47	London	England	United Kingdom
48	London	ON	Canada
49	Los Angeles	CA	USA
50	MH	\N	India
51	Madrid	Community of Madrid	Spain
52	Mexico City	CDMX	Mexico
53	Miami	FL	USA
54	Milpitas	CA	USA
55	Missoula	MT	USA
56	Munich	BY	Germany
57	New York City	NY	USA
58	Newport Beach	CA	USA
59	Olathe	KS	USA
60	Niagara Falls	NY	USA
61	Oslo	Oslo	Norway
62	Ottawa	ON	Canada
63	Paris	Île-de-France	France
64	Philadelphia	PA	USA
65	Portland	OR	USA
66	Remote	\N	\N
67	Sacramento	CA	USA
68	Salt Lake City	UT	USA
69	San Diego	CA	USA
70	San Francisco	\N	\N
71	San Francisco	CA	USA
72	Seattle	WA	USA
73	Shanghai	Shanghai	China
74	Silver Spring	MD	USA
75	Singapore	\N	Singapore
76	St. Louis	MO	USA
77	Sterling	VA	USA
78	Stockholm	Stockholm County	Sweden
79	Sydney	\N	Australia
80	Sydney	NSW	Australia
81	São Paulo	SP	Brazil
82	Toronto	\N	Canada
83	Toronto	ON	Canada
84	Traverse City	MI	USA
85	Troy	MI	USA
86	Vancouver	WA	USA
87	Victoria	BC	Canada
88	Virginia Beach	VA	USA
89	Washington	DC	USA
90	Waterloo	ON	Canada
\.


--
-- Data for Name: dimstatus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dimstatus (status_key, status_name) FROM stdin;
1	Active
2	Acquired
3	Public
4	Inactive
\.


--
-- Data for Name: factcompany; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.factcompany (company_key, slug, batch_key, location_key, status_key, team_size, company_age, founder_count, industry_count) FROM stdin;
1	10x-science	35	71	1	3	1	4	1
2	21st	35	71	1	3	2	2	2
3	42	12	71	1	\N	12	1	2
4	6thsense	31	71	1	\N	\N	4	2
5	7cups	1	88	1	11	\N	0	2
6	80-000-hours	26	47	1	13	15	1	1
7	83-sciences	31	71	1	3	0	3	1
8	9-mothers-corporation	34	7	1	19	2	3	2
9	9gag	3	36	1	36	19	2	2
10	abinitio-bio	34	15	1	2	0	2	2
11	absurd	36	49	1	6	1	4	2
12	adialante	34	71	1	4	3	2	2
13	advanced-metal-research	34	49	1	3	1	3	2
14	aemon	35	71	1	3	1	2	1
15	agentcard	31	71	1	\N	\N	3	1
16	agentic-fabriq	35	71	1	2	1	2	2
17	agentphone	34	\N	1	2	0	3	2
18	agilemd	16	71	1	19	15	1	2
19	agnost-ai	31	71	1	2	1	3	2
20	aice	34	71	1	2	0	2	2
21	airbnb	2	71	3	6132	18	3	2
22	aircaps	36	71	1	5	2	2	1
23	airhelp	12	45	1	350	13	1	2
24	akido-labs	7	49	1	1000	11	0	2
25	akkari	34	71	1	5	0	3	1
26	alara	37	\N	1	\N	1	2	1
27	albacore-inc	37	64	1	18	1	3	2
28	alchemize	34	71	1	2	0	2	2
29	alchemy	6	90	1	25	13	2	2
30	aleph-lab	36	71	1	2	1	3	1
31	algolia	12	71	1	810	14	2	2
32	alkera-ai	31	71	1	3	0	3	2
33	alloovium	31	17	1	5	0	2	2
34	allowance	34	71	1	1	0	1	2
35	allus-ai	36	5	1	3	1	3	2
36	alt-x	35	49	1	2	1	3	1
37	altur	37	52	1	5	3	2	1
38	ambition	12	21	1	55	12	3	2
39	amboras	34	71	1	3	1	2	1
40	amera	36	\N	1	8	1	4	2
41	amika	36	57	1	2	3	3	2
42	amplitude	10	71	3	750	14	2	2
43	amulet	31	71	1	2	0	2	2
44	andco	34	71	1	3	0	3	2
45	andustry	34	71	1	2	0	3	2
46	anoria	34	71	1	5	0	1	2
47	answerthis	36	71	1	6	2	3	1
48	antigen	36	71	1	5	0	2	2
49	anto-biosciences	36	71	1	4	1	3	1
50	apollo	16	71	1	200	14	2	2
51	apollo-atomics-inc	34	15	1	\N	\N	3	2
52	approxima	35	71	1	2	1	2	2
53	aptdeco	12	57	1	\N	12	2	2
54	aquashield	34	71	1	3	0	2	1
55	ara	34	71	1	2	0	5	2
56	arc-prize-foundation	35	71	1	4	2	1	1
57	archal	31	71	1	2	0	2	2
58	archer	34	71	1	4	0	2	2
59	arctic-health	34	71	1	4	1	3	2
60	arden	34	71	1	2	0	3	2
61	ardent	34	71	1	2	1	1	2
62	arga-labs	34	71	1	4	1	4	1
63	arlo-industries	34	71	1	3	1	2	2
64	armature	34	71	1	3	0	3	2
65	arzana	34	71	1	5	1	2	2
66	asendia-ai	34	71	1	3	1	3	1
67	aseon-labs	34	71	1	5	0	2	2
68	ashr	35	71	1	2	1	2	2
69	aside	36	71	1	3	2	5	1
70	asimov	35	71	1	3	0	1	2
71	aspect-inc	36	57	1	3	1	3	2
72	assemble	31	71	1	3	0	3	1
73	assembly	26	71	1	12	12	1	2
74	asseta	1	58	1	4	13	1	1
75	asterlab	34	71	1	2	0	1	2
76	astraea	34	71	1	2	0	2	1
77	atlas-discovery	31	71	1	3	0	2	2
78	atlasgrid	36	71	1	6	1	4	2
79	atrisa	34	71	1	3	0	4	2
80	aurorin-cad	35	71	1	1	0	1	2
81	automax-ai	36	71	1	4	1	1	2
82	autosana	37	71	1	5	1	4	2
83	autositu	35	\N	1	2	1	2	2
84	autumn-ai	35	71	1	2	1	2	2
85	auxos	34	71	1	3	0	3	1
86	avea-robotics	34	71	1	2	0	2	2
87	avelis-health	37	\N	1	3	1	3	2
88	avent	37	71	1	3	1	2	1
89	avoice	35	\N	1	4	1	3	1
90	axionorbital-space	35	71	1	2	1	3	2
91	axis-2	35	71	1	2	\N	4	1
92	backerkit	3	71	1	42	14	2	2
93	backpack	6	57	1	2	\N	1	2
94	bankjoy	7	85	1	60	11	1	2
95	baseframe	35	71	1	2	1	2	1
96	bayes-impact	6	71	1	11	\N	1	1
97	beacon-health	35	71	1	2	1	3	1
98	bear-flag-robotics	4	57	2	10	\N	2	2
99	beesafe-ai	35	71	1	3	1	4	2
100	bellabeat	12	71	1	134	12	1	2
101	benchling	3	71	1	750	14	0	1
102	bentolabs-ai	34	71	1	5	0	2	1
103	beyond-reach-labs	35	57	1	5	3	3	2
104	billiontoone	8	71	3	300	10	2	2
105	biostack-platforms	34	71	1	\N	1	2	1
106	bird	5	4	1	500	15	0	2
107	bitmovin	26	71	1	145	\N	1	2
108	bloomy	31	71	1	1	0	1	1
109	blue	37	71	1	6	2	3	1
110	blue-frog-gaming	9	1	1	11	\N	1	2
111	bluma	36	71	1	2	1	2	2
112	bodyport	26	71	1	19	11	2	2
113	bolna-ai	36	9	1	21	\N	2	1
114	booko	35	71	1	2	1	2	1
115	boom-ai	36	71	1	3	1	3	1
116	branch8	26	41	1	15	\N	0	2
117	bravi	36	71	1	2	1	3	1
118	brex	18	71	2	1000	9	2	2
119	brickanta	36	78	1	11	1	2	2
120	brickwise	36	47	1	2	1	3	2
121	bright	7	57	1	100	12	1	2
122	bron	36	71	1	2	1	4	2
123	brownie	35	71	1	2	1	3	2
124	bubble-lab	35	71	1	2	1	4	2
125	buildscience	7	60	1	1	11	1	2
126	buildzoom	19	71	1	100	13	1	2
127	burnt	37	71	1	3	3	3	2
128	burt	35	71	1	2	\N	5	2
129	button-computer	35	71	1	1	1	1	2
130	buxfer	17	71	1	1	20	2	2
131	byteport	35	71	1	4	1	1	1
132	caddy	36	57	1	5	1	3	2
133	cajal-technologies	35	71	1	2	1	3	1
134	callab-ai	34	71	1	7	2	2	2
135	cambly	12	71	1	200	\N	0	1
136	canary	35	71	1	2	0	2	2
137	caper	15	\N	2	15	\N	1	2
138	captain	35	71	1	2	1	2	2
139	cardboard	35	71	1	4	1	3	1
140	care-gp	31	80	1	10	2	1	1
141	caremessage	12	7	1	45	14	2	1
142	caretta	35	71	1	4	1	4	2
143	carrot-labs	35	71	1	2	0	4	1
144	carson	35	71	1	4	1	5	1
145	cascade	35	71	1	2	1	2	2
146	casetext	1	71	2	50	13	1	2
147	casey	36	71	1	5	1	4	2
148	catchback-cards	35	71	1	7	1	2	2
149	celltype	35	57	1	2	1	2	2
150	centralcoms	34	71	1	2	0	2	2
151	cerenovus	31	71	1	5	0	1	1
152	certus-ai	37	71	1	8	1	3	1
153	chaldal	26	28	1	2886	\N	2	2
154	chamber	35	72	1	4	0	5	2
155	char	37	71	1	4	3	5	2
156	characterquilt	34	71	1	4	2	2	2
157	chasi	35	71	1	2	1	3	1
158	chatfuel	15	71	1	53	\N	2	2
159	checkr	6	71	1	800	12	2	2
160	cheetah	19	71	1	2	\N	1	2
161	chert	34	71	1	2	0	2	1
162	chronicle-labs	34	71	1	2	0	1	1
163	cignara	34	71	1	4	1	1	1
164	circle-medical	26	\N	1	235	11	2	2
165	circuithub	10	47	1	58	14	1	2
166	circuitlab	19	71	1	2	14	2	2
167	clad-labs	36	71	1	2	1	2	1
168	claimglide	35	71	1	1	1	1	2
169	clara-2	34	71	1	9	1	3	2
170	clawvisor	34	71	1	1	0	1	2
171	cleanly	7	57	1	40	13	3	2
172	cleartax	6	9	1	900	15	2	2
173	clerky	16	71	1	35	15	2	2
174	clever	3	71	2	210	14	2	1
175	cleverdeck	10	71	1	1	\N	0	1
176	clicks	36	71	1	8	1	2	2
177	clipboard	18	71	1	1000	10	1	1
178	clodo	37	71	1	2	1	3	2
179	coasts	36	\N	1	2	1	2	2
180	coasty	31	71	1	2	0	2	1
181	codag	31	71	1	1	0	1	2
182	codecademy	16	57	2	225	15	1	1
183	codecombat	12	72	1	45	13	1	1
184	codenow	12	22	1	2	\N	1	1
185	codyco	36	34	1	4	1	3	1
186	cofactor-genomics	26	76	1	13	11	1	2
187	cofia	35	57	1	2	0	2	2
188	cognito	6	71	2	12	13	3	2
189	cohesion	34	57	1	3	0	3	2
190	coinbase	3	49	3	6112	14	1	2
191	comena	37	34	1	8	1	2	2
192	complir	34	71	1	13	2	3	2
193	complydo	36	12	1	10	1	5	2
194	compresr	35	\N	1	4	0	4	2
195	compyle	36	71	1	2	1	2	2
196	condor-energy	35	63	1	3	0	4	2
197	confident-lims	26	71	1	17	11	1	2
198	confluence-labs	35	71	1	2	1	2	1
199	congruent	35	71	1	2	1	2	1
200	conifer	31	71	1	3	1	2	1
201	constellation-space	35	72	1	4	1	4	2
202	contextdev	31	71	1	1	1	1	2
203	control-seat	31	71	1	2	1	2	1
204	convexia	37	71	1	4	1	3	2
205	copperlane	35	71	1	2	1	3	2
206	corelayer	35	71	1	3	1	3	2
207	coreos	1	71	2	150	\N	1	2
208	cortex-ai	36	71	1	3	1	1	2
209	corvera	35	71	1	4	1	4	2
210	cosmic-robotics	31	71	1	8	2	2	1
211	cova	31	27	1	5	0	2	1
212	cranston-ai	36	71	1	2	1	2	2
213	cratejoy	1	7	1	51	\N	2	2
214	crosslayer-labs	35	57	1	3	1	3	2
215	crow	35	71	1	2	0	4	1
216	cruise	12	71	2	3000	13	2	2
217	crunched	36	61	1	5	1	5	2
218	cumulus-labs	35	71	1	2	1	1	2
219	daily	15	71	1	126	10	1	2
220	daridev	36	71	1	2	1	2	2
221	datost	34	71	1	1	0	1	2
222	dayjob	34	47	1	5	1	2	2
223	deel	20	71	1	5000	7	2	2
224	deep-interactions	34	71	1	4	1	2	1
225	deepgram	15	71	1	115	11	0	2
226	deeptrace	36	71	1	4	1	2	1
227	definite	31	71	1	3	0	3	2
228	degla-inc	32	15	1	2	0	1	2
229	democracy-earth	7	51	1	2	11	3	1
230	denki	36	71	1	3	1	3	2
231	denta	31	71	1	1	1	1	2
232	dialogus	31	71	1	3	1	3	2
233	didit	35	71	1	16	3	2	2
234	digipals	36	71	1	3	1	4	2
235	diligencesquared-inc	36	57	1	3	1	2	2
236	discovered-materials	34	71	1	2	0	2	1
237	dispatch	34	71	1	2	1	2	2
238	ditto-biosciences	35	71	1	3	1	4	2
239	docura-health	35	71	1	3	0	1	1
240	doomersion	35	71	1	4	1	1	1
241	doordash	1	71	3	8600	13	3	2
242	double-robotics	3	71	1	11	14	2	2
243	drafted	34	71	1	9	1	1	1
244	drchrono	22	71	2	150	17	2	2
245	drip-capital	26	50	1	280	10	0	1
246	drippay	34	71	1	2	0	1	2
247	dropbox	9	71	3	4000	18	2	2
248	duranium	37	71	1	10	1	2	2
249	dyspatch	12	87	1	20	\N	1	2
250	earendil-robotics	31	71	1	7	1	2	2
251	easypost	1	71	1	51	\N	1	2
252	ebrandvalue	7	71	1	10	\N	0	2
253	eden-robotics	34	71	1	4	1	3	2
254	edviro	31	71	1	2	1	2	2
255	efference	36	71	1	1	1	1	2
256	eigenpal	35	71	1	\N	1	2	2
257	eight-sleep	26	57	1	100	12	3	2
258	ekpa	31	15	1	2	0	2	2
259	eligible	3	57	1	\N	15	0	2
260	elyra	34	78	1	2	\N	2	1
261	emailio	12	66	1	5	\N	1	2
262	embark-trucks	15	71	3	300	10	2	2
263	emdash	35	71	1	2	1	2	2
264	end-close	35	\N	1	2	0	2	2
265	enjamb-labs	34	71	1	2	1	2	1
266	envariant	35	71	1	1	1	1	1
267	eos-ai	35	71	1	2	1	1	1
268	equipmentshare	7	24	3	5400	12	4	2
269	estimote-inc	1	42	1	40	14	2	2
270	etleap	19	71	1	11	\N	1	2
271	everest	36	71	1	\N	0	2	1
272	exonic	36	71	1	3	1	2	2
273	expanse	34	71	1	4	1	4	2
274	expected-parrot	36	15	1	5	2	3	1
275	experiential-labs	31	71	1	2	0	2	2
276	experiment	19	37	1	1	14	1	2
277	f2	37	57	1	15	1	2	2
278	f4-industries	37	71	1	5	1	2	1
279	fabraix	31	71	1	2	0	2	2
280	faire	18	71	1	900	9	3	2
281	fastshot	36	71	1	3	1	2	2
282	fed10	35	71	1	3	1	5	2
283	fenrock-ai	35	71	1	2	0	3	2
284	fern-bot	35	\N	1	2	1	2	2
285	fernstone	36	57	1	2	1	2	2
286	finaldose	34	47	1	5	1	3	2
287	finto-de	37	56	1	10	1	4	2
288	fivestars	22	71	2	201	16	2	2
289	fivetran	19	71	1	1200	14	2	2
290	fixture	35	\N	1	5	0	2	2
291	flaviar	6	46	1	60	14	3	2
292	fleetline	37	57	1	11	1	2	2
293	flexport	12	71	1	3000	13	1	2
294	flick	36	71	1	2	1	2	2
295	flightfox	3	16	1	25	14	2	2
296	flip	7	49	1	\N	12	1	2
297	flirtey	26	13	1	11	\N	1	2
298	flock-safety	8	5	1	1000	9	2	2
299	floot	37	71	1	4	1	3	2
300	floracene	31	57	1	2	0	2	1
301	florin	31	71	1	3	0	3	1
302	flowmanual	31	71	1	2	0	2	2
303	flowscope	34	71	1	2	1	4	1
304	flywheel-ai	37	71	1	2	3	2	2
305	foaster	34	71	1	2	0	2	1
306	focal-systems	15	71	1	170	10	0	2
307	font-awesome	26	10	1	17	12	2	2
308	foreman	35	71	1	2	0	2	1
309	foresight	34	57	1	2	1	2	2
310	forge-robotics	36	71	1	1	1	2	2
311	fort	35	71	1	3	1	3	2
312	forum	35	71	1	2	0	2	1
313	fountain	26	71	1	200	11	1	2
314	framewise-health	34	71	1	2	0	2	1
315	freeport-markets	36	57	1	3	1	2	2
316	freya	37	71	1	14	1	3	1
317	front	6	71	1	385	13	2	2
318	fuchsia	34	71	1	3	1	1	1
319	fullseam	35	\N	1	3	0	4	2
320	fundersclub	3	71	1	5	14	2	2
321	futureadvisor	11	71	2	51	16	1	2
322	gbatteries	12	62	1	25	12	0	2
323	gemnote	26	71	1	40	\N	0	2
324	general-aviation	34	71	1	\N	0	1	2
325	general-instinct	34	71	1	2	0	2	2
326	general-legal	35	\N	1	25	0	4	2
327	generalastro	35	71	1	2	1	2	2
328	geo-ai	37	57	1	\N	1	2	2
329	getaccept	15	71	1	200	10	3	2
330	getbalance	35	47	1	4	0	5	2
331	ghosteye	37	57	1	7	1	1	2
332	gigacatalyst	34	71	1	4	1	1	2
333	ginkgo-bioworks	6	15	3	641	17	5	2
334	gitlab	7	71	3	2000	14	2	2
335	gitprime	15	29	2	110	12	2	2
336	givecampus	26	89	1	130	12	0	1
337	giveffect	7	57	1	\N	12	2	2
338	givemetap	7	47	1	1	15	1	2
339	glen	31	71	1	1	0	1	2
340	glue	35	71	1	2	0	1	2
341	go1	26	71	1	650	11	3	2
342	goat-group	22	49	1	1600	11	2	2
343	gocardless	16	47	1	900	15	2	2
344	godhands	32	71	1	2	0	1	1
345	gojiberry-ai	34	71	1	7	1	4	2
346	goldbelly	19	57	1	125	13	3	2
347	govguard	34	71	1	\N	\N	2	1
348	gpt	36	18	1	2	2	2	1
349	grade	35	71	1	2	1	2	1
350	gravy	34	71	1	2	\N	4	2
351	greentoe	6	57	1	5	14	1	2
352	greypoint-industries	31	71	1	4	0	4	2
353	groww	4	9	3	1050	10	4	2
354	grubmarket	7	71	1	4548	12	0	2
355	guesty	12	57	1	700	13	2	2
356	guild	31	57	1	2	1	2	2
357	gusto	10	71	1	2400	15	3	2
358	hackerrank	16	71	1	300	\N	1	2
359	haladir	35	71	1	4	1	4	2
360	healthsherpa	3	67	1	220	13	1	2
361	heap	19	72	2	388	13	1	2
362	hedge	34	71	1	2	0	2	2
363	helion-energy	6	72	1	150	13	2	2
364	hellosign	22	71	2	100	\N	1	2
365	helonic	36	71	1	2	1	2	2
366	hera-video	37	11	1	5	1	3	2
367	heroic-labs	26	47	1	21	12	3	2
368	heroku	23	71	2	300	19	2	2
369	hessian	34	71	1	3	0	3	1
370	hevn-inc	34	\N	1	4	0	4	1
371	hex-security	35	71	1	10	0	6	2
372	hexa	34	71	1	3	0	4	2
373	heyclicky	34	71	1	\N	0	0	1
374	hillclimb	36	71	1	4	1	2	2
375	hive	6	40	1	65	12	1	2
376	hlabs	35	71	1	1	1	1	1
377	honeylove	14	49	1	100	8	1	2
378	hop-aero	31	49	1	6	2	2	2
379	hoplite	31	71	1	2	0	2	2
380	hub	34	71	1	10	2	3	2
381	human-archive	35	71	1	4	0	5	2
382	human-dx	3	71	1	11	\N	1	2
383	human-interest	26	71	1	765	11	2	2
384	humoniq	37	71	1	5	1	3	1
385	huscarl	34	71	1	2	1	3	2
386	hyper-4	34	71	1	2	0	2	2
387	hypercubic	36	71	1	3	1	2	1
388	hyperpad	6	48	1	4	13	2	2
389	hyperprobe	31	71	1	8	0	2	2
390	hyperspell	36	71	1	8	2	2	2
391	icarus	36	49	1	50	3	1	2
392	idler	37	71	1	13	1	5	2
393	imagine-ai	36	71	1	5	1	3	2
394	immunity-project	12	71	1	11	\N	3	1
395	imperfect	34	71	1	5	0	1	1
396	incandor	34	71	1	\N	\N	2	1
397	industrial-microbes	7	71	1	12	12	2	2
398	infera	34	71	1	2	0	2	2
399	influxdata	19	57	1	210	14	1	2
400	inkbox	31	71	1	3	1	3	2
401	inloop-robotics	34	71	1	4	0	2	2
402	insforge	34	71	1	6	1	3	2
403	instaagent	34	71	1	9	1	3	2
404	instacart	3	71	3	3000	14	3	2
405	instance	31	71	1	2	0	2	1
406	instawork	26	71	1	500	10	1	2
407	instinct-xyz	35	71	1	5	0	2	1
408	insurf	31	71	1	2	0	3	1
409	intelligence-factory	34	71	1	5	0	2	2
410	interfaze	34	71	1	5	1	3	2
411	interfere	37	57	1	8	1	1	2
412	inth	34	71	1	3	1	1	2
413	inventoryquant	35	71	1	1	1	2	1
414	inviscid-ai	35	75	1	2	1	2	2
415	iron-grid	37	71	1	2	1	2	2
416	ironclad	26	71	1	700	12	1	2
417	isengard-industries-inc	31	33	1	30	0	2	2
418	isono-health	15	71	1	9	10	1	2
419	item	36	71	1	6	2	2	2
420	jarmin	36	71	1	5	1	4	1
421	jinba	35	\N	1	2	\N	2	1
422	juno-chat	34	71	1	2	1	3	2
423	justinian	31	71	1	2	0	1	1
424	juxta	37	71	1	\N	2	1	1
425	kaigo-health	36	71	1	3	1	3	2
426	kalpa-labs	36	71	1	2	1	3	1
427	karumi	36	\N	1	5	1	3	2
428	kelai	34	57	1	3	1	1	2
429	kernel	37	71	1	6	1	2	2
430	kestrel-ai	36	71	1	2	1	1	2
431	keyframe-labs	34	71	1	2	1	2	1
432	kimpton-ai	34	71	1	5	1	3	2
433	kinect	34	71	1	2	0	2	1
434	kinro	34	71	1	3	0	5	2
435	kita	35	71	1	3	1	2	1
436	klaimee	34	71	1	2	0	3	2
437	klarify	34	71	1	4	2	4	2
438	klaus-ai	35	71	1	2	1	2	2
439	knowlify	37	71	1	6	1	4	1
440	korso	34	49	1	3	0	3	1
441	koyal	36	71	1	5	1	4	2
442	kugelaudio	34	71	1	4	1	2	2
443	kuli	34	71	1	1	\N	2	2
444	kyten-technologies	35	72	4	2	0	3	2
445	lab0	34	71	1	3	0	5	1
446	labdoor	7	71	1	11	14	3	2
447	lakonia	36	71	1	2	1	2	1
448	lamina-labs	34	71	1	2	1	2	2
449	lance	35	71	1	10	0	3	1
450	lapis	36	71	1	5	1	3	2
451	lato	31	71	1	2	0	2	1
452	lattice	15	71	1	540	11	2	2
453	lattice-health	34	71	1	1	0	1	1
454	laurence	35	57	1	2	1	2	2
455	lawdingo	19	57	1	\N	\N	1	2
456	leadbay	36	71	1	8	\N	3	2
457	leaders-in-tech	26	71	1	1	\N	1	1
458	legalos	35	71	1	3	2	4	2
459	lemonlime	31	71	1	5	0	3	1
460	level-frames	7	57	1	5	12	2	2
461	lever	3	71	2	225	14	3	2
462	levocred-ai	31	71	1	2	1	3	1
463	lexi	36	71	1	15	1	3	2
464	lexius	35	71	1	3	2	3	2
465	libra-robotics	31	71	1	\N	\N	2	2
466	light-anchor	34	71	1	2	0	2	1
467	lightberry	36	71	1	3	1	3	2
468	lightsprint	34	71	1	3	0	3	2
469	limrun	34	71	1	1	1	1	2
470	linzumi	34	71	1	3	1	1	2
471	litmus-hiring	31	57	1	4	1	2	2
472	lob	1	57	1	150	\N	0	2
473	locata	37	57	1	4	1	3	2
474	locus	36	70	1	2	1	1	2
475	logical	36	71	1	2	1	3	2
476	logosguard	36	71	1	2	1	3	1
477	lollipuff	19	71	1	11	\N	1	2
478	lua-global-inc	36	47	1	5	1	2	1
479	lucent	35	71	1	2	1	1	1
480	lucira-health	7	32	3	43	\N	1	2
481	luel	35	71	1	12	1	2	2
482	lugg	26	71	1	50	12	2	2
483	luminal	37	71	1	5	1	4	2
484	lumius	34	30	1	4	\N	2	2
485	lunabill	36	71	1	4	1	2	2
486	lunavo	36	71	1	2	1	2	2
487	machine-zone	23	71	2	501	18	1	2
488	machine0	31	71	1	1	0	1	2
489	madethis	36	71	1	4	1	2	2
490	madrone	34	71	1	2	1	3	2
491	magic	7	89	1	350	11	5	1
492	magicbus	15	49	1	18	\N	2	2
493	magnetic	37	71	1	10	2	2	2
494	makrwatch	7	57	1	19	9	2	2
495	mango-medical-inc	35	\N	1	3	2	2	2
496	manicule	34	71	1	5	1	2	2
497	mantis	35	57	1	3	1	1	2
498	manufact	37	71	1	5	1	4	2
499	maquoketa-research	34	71	1	5	1	3	2
500	markhor	26	71	1	5	\N	2	2
501	markit	36	71	1	2	1	3	2
502	markov	31	71	1	2	0	2	2
503	martini	35	71	1	2	1	3	2
504	mashgin	7	71	1	150	12	2	2
505	mason	15	72	1	65	11	1	1
506	mattermost	3	71	1	120	10	1	2
507	matterport	10	71	3	201	\N	1	2
508	maven	35	71	1	2	1	2	2
509	maximal	37	71	1	3	1	2	2
510	mayflower	36	71	1	2	1	2	1
511	maywood	35	57	1	5	\N	3	2
512	mbx	12	71	1	150	14	1	2
513	meadow	7	71	1	14	12	3	2
514	medmonk	10	54	1	2	\N	2	2
515	meesho	5	9	3	1450	11	2	2
516	memoir	34	71	1	2	0	2	2
517	memory-store	34	71	1	4	1	3	2
518	mendral	35	71	1	2	1	2	1
519	metorial	36	66	1	4	1	2	1
520	metricwire	6	40	1	3	\N	0	2
521	mezmo	7	53	1	172	11	1	2
522	microhealth	26	19	1	10	11	1	2
523	milliray	35	47	1	3	\N	3	2
524	mimos	37	57	1	1	1	1	1
525	minicor	34	71	1	7	2	2	2
526	minimal-ai	37	3	1	3	2	3	1
527	miniswap	36	71	1	2	1	3	2
528	minro	36	71	1	2	1	2	2
529	mio	15	7	1	12	11	2	2
530	mireye	31	71	1	2	0	1	2
531	miso-labs	34	71	1	2	1	3	2
532	mixerbox	12	49	1	30	\N	1	1
533	mixpanel	25	71	1	410	17	3	2
534	mixy	36	\N	1	2	1	3	1
535	mochacare	35	71	1	2	0	2	2
536	mochatrade	34	71	1	3	0	3	2
537	mod-ai	36	71	1	4	1	5	1
538	moda	35	71	1	5	1	2	2
539	modelence	37	71	1	3	1	3	2
540	modern	34	71	1	2	0	4	2
541	modern-fertility	8	71	2	25	9	2	2
542	molagri	31	83	1	4	0	2	2
543	momentus	14	71	3	125	9	1	2
544	moritz	35	71	1	10	1	3	2
545	moss	36	71	1	5	2	3	1
546	motives	37	47	1	\N	\N	3	2
547	mount	34	71	1	2	0	2	2
548	mousecat	35	57	1	2	0	2	1
549	movedot	36	71	1	10	2	3	2
550	moxion-power-co	27	71	4	380	6	2	2
551	mtailor	6	71	1	11	14	0	2
552	mth-sense	3	71	1	11	\N	0	2
553	multifactor	36	71	1	6	1	1	2
554	munify	37	66	1	4	1	1	1
555	mux	15	71	1	95	10	4	2
556	napkin-math	34	71	1	3	0	3	1
557	nautilus	37	71	1	4	2	3	2
558	ndea-com	35	66	1	15	2	2	1
559	nebula-security	31	86	1	4	0	3	2
560	nerviom	36	71	1	1	1	2	1
561	nessie	36	71	1	2	1	3	1
562	netter	34	71	1	4	0	2	2
563	new-story	26	5	1	20	12	2	1
564	newfront-insurance	4	71	2	800	9	2	2
565	newsblur	3	71	1	1	14	1	2
566	nimblerx	7	71	1	130	11	0	2
567	nine-fives	34	71	1	2	1	2	2
568	noora-health	12	84	1	500	12	1	1
569	noril1	31	57	1	4	0	1	2
570	normal	37	71	1	2	1	2	1
571	norra	36	71	1	2	1	3	1
572	north	19	40	2	51	\N	1	2
573	noso-labs	37	71	1	3	1	2	1
574	notte	37	71	1	5	1	2	1
575	novaflow	37	71	1	5	1	2	1
576	nowports	20	\N	1	550	8	3	2
577	nox-metals	37	27	1	27	1	1	2
578	nozomio	37	71	1	5	1	1	2
579	nucleo	36	\N	1	2	1	3	1
580	numerion-labs	7	71	1	67	\N	1	2
581	nurx	15	57	2	300	11	1	2
582	o11	35	71	1	2	1	4	2
583	octapulse	35	\N	1	2	1	2	2
584	octavewealth	3	71	1	2	\N	1	2
585	oddpool	34	71	1	2	0	2	2
586	odeko	29	57	1	371	7	1	1
587	okibi	37	71	1	2	1	3	1
588	oklo	6	71	3	50	13	2	2
589	omgpop	28	57	2	11	\N	1	2
590	omnara	37	71	1	4	1	3	2
591	one-degree	12	71	1	14	14	1	1
592	one-robot	35	71	1	2	1	2	2
593	onecli	31	71	1	\N	\N	2	2
594	onesignal	16	71	1	150	15	2	2
595	ontora	34	71	1	3	0	3	2
596	ooak-data	31	63	1	5	2	2	1
597	opalite-health	35	71	1	3	1	2	1
598	opencurriculum	12	67	1	\N	15	0	1
599	openinvest	26	71	2	110	11	1	1
600	opennote	37	71	1	3	1	4	1
601	openprose	34	71	1	3	0	1	2
602	openrelay	31	72	1	2	0	2	2
603	openroll	36	78	1	4	2	2	1
604	openspec	35	79	1	\N	1	1	1
605	opentrade	31	72	1	3	0	2	1
606	openwork	34	71	1	4	0	1	2
607	operon	31	71	1	\N	0	1	1
608	optimizely	24	71	2	1500	\N	1	2
609	origami-robotics	35	71	1	5	0	2	1
610	origin-bio	35	71	1	4	1	2	2
611	ornadyne	34	49	1	4	0	2	2
612	orthogonal	35	71	1	2	1	2	2
613	os3	31	71	1	2	1	2	2
614	osmaura	31	71	1	2	0	2	1
615	osseus	31	\N	1	2	0	2	2
616	ossus	35	71	1	3	0	3	2
617	outrove	37	71	1	2	1	2	1
618	outschool	15	71	1	107	11	0	1
619	overshoot	35	71	1	5	1	2	1
620	oximy	35	71	1	4	1	2	2
621	oxus	35	71	1	3	1	4	1
622	padlet	19	71	1	65	14	1	2
623	pagerduty	11	71	3	950	\N	1	2
624	pairio	34	71	1	3	1	3	1
625	palette-2	31	71	1	2	0	2	1
626	pally	37	71	1	3	2	2	2
627	paloma	37	71	1	3	1	2	1
628	palus-finance	35	\N	1	2	\N	2	1
629	panacea	34	71	1	2	0	3	2
630	pango	31	78	1	5	1	2	2
631	panorama-education	1	49	1	350	14	1	1
632	panta	35	71	1	3	1	2	2
633	parasma	31	71	1	1	0	2	2
634	pardes-bio	13	71	3	2	6	1	2
635	pares-ai	37	49	1	3	1	1	1
636	parrot	36	71	1	3	2	3	1
637	parse-bot	36	71	1	2	1	1	1
638	partnerstack	26	83	2	200	11	4	2
639	patent-watch	36	83	1	4	1	3	1
640	patientdeskai	35	\N	1	5	1	3	2
641	pavoot	34	71	1	\N	0	2	2
642	pax-historia	35	71	1	3	1	2	2
643	payna	35	71	1	2	1	3	1
644	paystack	15	43	2	115	\N	2	2
645	pentagon	34	68	1	1	0	2	2
646	per-vices	10	83	1	11	21	0	1
647	perceptron-ml	31	71	1	2	0	2	1
648	perfectbit-inc	34	71	1	2	0	2	1
649	perfectly	35	71	1	4	1	6	2
650	permutive	6	47	1	205	\N	2	2
651	perseus	36	9	1	4	1	1	2
652	perseus-defense	37	6	1	3	1	3	2
653	perspectives-health	37	22	1	5	2	2	2
654	petcube	15	71	1	51	14	2	2
655	petrarch	31	71	1	3	0	3	1
656	phases	37	71	1	3	1	3	2
657	philon	36	71	1	\N	1	1	1
658	physical-turing	37	71	1	2	1	2	2
659	picktrace	26	49	1	65	11	1	2
660	picnicai	6	71	1	100	12	2	1
661	piinpoint	12	40	1	20	13	2	2
662	pirislabs	35	71	1	8	1	2	2
663	pixley-ai	36	49	1	2	1	5	2
664	plan0-ai	34	\N	1	4	0	3	1
665	plangrid	10	71	2	355	\N	4	2
666	plate-iq	26	47	1	200	11	1	2
667	platzi	7	71	1	123	12	1	2
668	play-health	36	16	1	4	1	0	1
669	playablai	34	71	1	10	1	3	2
670	plena-health	34	71	1	\N	1	2	2
671	pleom	37	57	1	\N	1	1	2
672	plivo	3	7	1	320	15	2	1
673	ploy	34	71	1	14	1	1	1
674	pocket	35	71	1	15	2	2	1
675	podium	15	44	1	1000	12	3	2
676	pollen	35	71	1	3	1	4	2
677	pollinate	35	71	1	2	2	2	2
678	polymath	35	71	1	2	0	2	1
679	polymorph	35	71	1	4	0	2	1
680	pops	34	57	1	1	0	2	2
681	poth-labs	31	71	1	2	0	2	1
682	povio	12	20	1	250	12	1	2
683	prana-health	35	71	1	4	1	3	2
684	praxis-ai-2	31	71	1	3	0	3	1
685	prescience-inc	31	15	1	2	0	3	1
686	primer	36	49	1	2	1	2	1
687	primitive	34	71	1	4	0	1	2
688	prized	31	71	1	2	0	2	2
689	procindex	37	71	1	4	1	2	2
690	projectx	34	71	1	6	4	3	2
691	protent	35	71	1	2	1	2	2
692	protocol-labs	6	71	1	130	12	1	2
693	prototypingio	34	71	1	2	0	2	2
694	provenmetal	31	71	1	4	0	2	2
695	proximitty	35	71	1	2	0	2	2
696	proxy	5	71	2	20	10	3	2
697	pushbullet	12	71	1	3	13	3	2
698	qomplement	34	71	1	7	1	3	1
699	quantierra	7	57	1	5	\N	0	2
700	quartzy	16	71	1	100	\N	2	2
701	quotain	37	57	1	2	1	2	2
702	qventus	7	71	1	230	14	1	2
703	radar	19	57	1	120	\N	1	2
704	rainforest	3	71	1	40	14	2	2
705	ramain	35	71	1	4	1	2	1
706	rappi	15	14	1	4800	11	3	2
707	raspire	34	71	1	3	1	3	2
708	razorpay	7	9	1	2700	12	2	2
709	reach	26	71	1	45	\N	1	2
710	reacher	37	71	1	10	2	3	1
711	readme	7	57	1	52	11	1	2
712	realpact	31	71	1	3	1	2	2
713	realroots	37	71	1	7	2	2	2
714	reasonblocks	34	71	1	2	\N	2	1
715	rebulk	37	59	1	3	1	2	2
716	redapto	36	71	1	2	1	1	1
717	redcarpetup	26	35	1	100	\N	1	2
718	reddit	21	71	2	2000	\N	1	2
719	reebee	1	40	1	11	\N	1	2
720	relling	37	71	1	\N	1	2	2
721	remix-3	35	71	1	\N	1	1	1
722	rentahuman	34	71	1	3	0	1	2
723	replicas	34	71	1	2	0	2	2
724	replika	7	71	1	28	\N	1	2
725	resolve	7	57	1	10	12	2	2
726	ressl-ai	35	71	1	3	1	3	1
727	result	34	\N	1	2	0	4	1
728	rev1	35	71	1	2	0	2	2
729	revion	35	57	1	10	1	2	1
730	revnu	34	71	1	2	0	3	2
731	rex-inc	31	47	1	2	0	2	2
732	rhizome-ai	35	57	1	1	1	2	1
733	rigetti-computing	6	71	3	51	\N	1	2
734	rightnow	32	2	1	2	1	2	2
735	rindler	31	15	1	2	1	3	2
736	rippling	18	71	1	2500	10	2	2
737	rise-reforming	31	22	1	4	2	3	2
738	risely-ai	37	71	1	9	1	3	1
739	risklytics	31	71	1	2	0	2	2
740	ritivel	35	71	1	3	1	4	2
741	river-markets	34	71	1	2	0	2	1
742	rivet-design	36	71	1	\N	1	1	2
743	robby	35	15	1	3	1	3	2
744	robocurve	31	71	1	2	0	2	2
745	robodock	35	71	1	3	1	2	2
746	roomstorm	6	71	1	4	\N	1	2
747	rote	33	71	1	\N	0	2	2
748	rovi-health	36	57	1	3	1	2	1
749	rowflow	37	57	1	2	1	3	2
750	rudus	34	71	1	2	0	2	2
751	ruma-care	35	71	1	2	1	3	1
752	runanywhere	35	71	1	5	1	3	2
753	runharbor	34	71	1	3	1	2	1
754	runtime	34	71	1	3	0	3	2
755	ruvo	37	81	1	6	1	2	1
756	s2-dev	36	71	1	5	2	4	2
757	saffron	34	71	1	3	1	5	2
758	sails-co	7	7	1	4	\N	3	2
759	salem-robotics-inc	31	7	1	2	0	2	2
760	salesgraph	34	71	1	2	0	3	2
761	salus	35	71	1	2	0	1	2
762	samora-ai	35	\N	1	8	1	3	1
763	saudara-ai	34	71	1	2	1	2	1
764	savahq	36	57	1	3	1	2	1
765	savant	34	71	1	2	0	2	2
766	sazabi	34	71	1	10	1	1	2
767	scale-ai	5	71	1	500	10	1	2
768	scentbird	26	57	1	165	13	1	2
769	scheduling-wizard	35	89	1	3	2	4	2
770	sciloop	36	71	1	2	1	2	2
771	scoop	36	71	1	2	1	3	1
772	scope	34	71	1	2	1	1	1
773	scott-ai	36	57	1	3	1	3	1
774	screenleap-inc	10	71	1	4	15	1	2
775	screenpipe	31	71	1	6	2	1	2
776	scribd	28	71	1	300	19	1	2
777	seeing-systems	35	47	1	2	1	2	2
778	segment	16	71	2	550	15	1	2
779	selfin	36	71	1	2	1	3	2
780	sellraze	36	71	1	6	3	3	1
781	semble-ai	36	71	1	2	1	2	1
782	semiotic	36	71	1	3	1	3	2
783	sendwave	10	15	2	350	12	1	2
784	sentrial	35	71	1	2	1	2	2
785	sequence-markets	35	82	1	5	0	3	1
786	servo7	35	4	1	3	1	2	2
787	sf-tensor	36	\N	1	6	1	4	2
788	sfox	6	49	1	60	12	2	2
789	shape-shapescale	26	71	1	7	11	2	2
790	shasqi	7	71	1	28	11	1	2
791	shepherd-3	31	71	1	3	0	3	1
792	sherpa	34	71	1	2	0	3	1
793	shipbob	6	22	1	1	12	2	2
794	shofo	35	71	1	4	1	3	2
795	shoobs	12	47	1	5	13	1	2
796	shoptiques	10	57	1	51	\N	4	2
797	shortkit	35	\N	1	2	0	3	2
798	shotwellai	34	71	1	4	0	4	2
799	shred-video	26	71	1	2	\N	0	2
800	sigmanticai	37	71	1	2	1	2	2
801	sila	35	57	1	2	0	2	2
802	silmaril	34	71	1	2	0	2	1
803	simantic	32	90	1	4	1	2	2
804	simplyinsured	19	71	1	35	14	1	2
805	sira	37	71	1	4	1	2	2
806	sirum	7	71	1	15	\N	0	1
807	sitefire	35	71	1	2	1	2	2
808	skillsync	35	71	1	2	1	2	2
809	skymerse	31	71	1	\N	1	1	2
810	smartasset	3	57	1	210	\N	1	2
811	smartbase	34	71	1	2	1	2	2
812	smol-machines	34	71	1	1	0	1	2
813	snapdocs	12	65	1	285	12	1	2
814	snapmagic	26	71	1	23	\N	1	2
815	socratix-ai	37	71	1	4	1	3	2
816	solbrowser	36	71	1	2	1	3	2
817	solva	37	57	1	15	1	3	2
818	sonarly	35	71	1	2	1	2	2
819	sorce	36	71	1	5	2	3	2
820	soren	36	71	1	\N	1	2	1
821	soria	34	57	1	3	1	3	2
822	soundboks	15	25	1	50	\N	0	2
823	sourcebot	36	71	1	3	2	2	2
824	sparkles	35	71	1	1	1	2	2
825	specific	36	78	1	2	1	3	2
826	specific-labs	36	71	1	2	1	5	1
827	speko	31	71	1	4	0	1	2
828	sponge	35	71	1	3	0	3	1
829	spotangels	6	71	1	11	\N	0	2
830	spotlight-realty	37	71	1	4	1	3	1
831	spotpay	35	71	1	2	1	3	2
832	sqreen	4	71	2	120	11	1	2
833	squid	35	47	1	3	0	4	2
834	stablebrowse	34	71	1	3	0	3	2
835	stage	34	71	1	2	0	2	2
836	stagewise	37	\N	1	2	2	2	2
837	standard-signal	34	57	1	1	0	1	2
838	standout	34	71	1	3	1	4	2
839	stealth-worker	15	71	1	5	11	1	2
840	stilta	35	78	1	4	0	5	1
841	strand-ai	35	71	1	2	1	4	2
842	streak	16	71	1	35	14	1	2
843	strikingly	19	73	1	99	14	3	2
844	stripe	25	71	1	7000	17	2	1
845	structured-ai	36	57	1	10	1	3	2
846	styleup	19	71	1	10	14	0	2
847	submittable	3	55	1	302	16	1	1
848	sunfarmer	26	39	1	15	\N	2	2
849	sunflower	36	71	1	15	2	1	1
850	supafax	35	71	1	2	1	2	2
851	superlog	34	71	1	2	0	2	2
852	superset	34	71	1	3	0	6	2
853	surtr-defense-systems	34	71	1	2	0	2	2
854	svbtle	3	71	1	2	\N	1	2
855	synphony	34	71	1	10	1	3	2
856	synthetic-sciences	35	71	1	2	1	2	2
857	syntropy	35	71	1	2	1	2	2
858	tab	7	47	1	9	11	1	2
859	taiga	34	71	1	2	0	2	2
860	takecareos	34	71	1	1	0	2	1
861	talentpluto	31	57	1	5	1	3	2
862	talking-computers	35	\N	1	2	1	2	1
863	tara-ai	7	71	1	13	8	2	2
864	tasklet-2	34	71	1	8	1	3	2
865	tdaycom	34	71	1	2	0	2	2
866	teabot	26	83	1	2	13	1	2
867	teamnote	7	36	1	11	12	1	2
868	tectoai	37	71	1	2	1	3	1
869	telemetron-ai	36	71	1	2	1	1	1
870	teleport	26	71	1	255	11	3	2
871	tell-if-ai	36	7	1	2	1	4	2
872	tempo	7	71	1	158	12	2	2
873	tenet-industries	34	71	1	3	0	4	2
874	tensr	36	71	1	3	1	4	2
875	tepali	35	57	1	2	0	2	1
876	terminal-use	35	71	1	4	0	4	2
877	terrain	36	71	1	2	1	2	2
878	terranox-ai	35	71	1	2	1	2	2
879	tesorio	26	71	1	53	13	1	2
880	testerarmy	34	71	1	4	0	3	2
881	tetrascience	26	15	1	100	\N	0	2
882	textsidekick	34	71	1	1	0	1	2
883	the-athletic	5	71	2	600	10	2	2
884	the-company-company	34	71	1	1	0	1	1
885	the-context-company	36	71	1	2	1	3	2
886	the-hog	36	70	1	2	1	1	2
887	the-human-utility	7	71	1	2	\N	1	1
888	the-ticket-fairy	26	49	1	30	15	2	2
889	the-token-company	35	71	1	2	1	1	2
890	thesis	36	71	1	3	1	3	1
891	thomas	34	71	1	2	0	0	1
892	thrive-agritech	26	72	1	8	11	0	2
893	tolmo	34	71	1	12	0	2	2
894	tornyol	36	63	1	7	\N	3	2
895	torus	31	71	1	5	0	3	1
896	totalis	34	71	1	\N	0	2	2
897	touchmark	31	71	1	2	\N	2	2
898	tovala	15	22	1	375	11	1	2
899	transload	34	71	1	3	0	3	2
900	traverse	35	71	1	1	1	1	1
901	travo	35	71	1	4	1	4	1
902	trelium	36	71	1	6	1	2	1
903	trellistech	34	71	1	5	0	4	2
904	trope	31	71	1	2	0	3	1
905	true-link	1	57	1	100	14	1	1
906	truebill	15	74	2	225	11	3	2
907	truevault	12	71	1	\N	13	1	1
908	truffle	31	57	1	2	0	2	1
909	trustai	31	71	1	3	0	2	2
910	trybloom	34	71	1	3	1	2	1
911	trycardinal-ai	35	71	1	\N	\N	2	1
912	tryprism	34	47	1	4	1	3	2
913	tsenta	31	71	1	2	0	2	2
914	twentytwo	37	57	1	3	1	1	2
915	twitch	17	71	2	2000	20	3	2
916	twolabs	34	71	1	2	0	3	2
917	understudy-labs	31	71	1	2	0	2	2
918	unifold	35	57	1	3	0	3	2
919	unisson	35	71	1	2	0	2	2
920	uno-wallet	34	71	1	2	0	1	2
921	unsiloed-ai	36	71	1	2	1	4	1
922	uplane	36	71	1	19	1	3	2
923	uplift-ai	37	71	1	3	2	3	1
924	upwave	3	71	1	50	14	1	2
925	uselemma	36	71	1	2	1	3	2
926	usenarrative	36	71	1	3	1	3	2
927	useparrot	34	71	1	2	0	2	1
928	usereframe	35	71	1	1	1	2	2
929	usergems	6	8	1	100	11	2	2
930	userlens	34	71	1	4	1	3	2
931	valctrl	34	57	1	2	1	2	2
932	valence	35	71	1	3	0	3	2
933	valgo	35	71	1	3	1	5	2
934	vastrm	3	71	1	2	14	1	2
935	vector-legal	35	71	1	5	0	2	2
936	vela	35	71	1	2	0	2	1
937	velum-labs	35	71	1	2	1	2	1
938	velvet	36	71	1	4	1	2	1
939	ventura	35	71	1	2	1	3	1
940	verdant	31	71	1	2	0	2	1
941	verdex	35	71	1	2	1	2	2
942	verge-genomics	26	71	1	50	11	0	2
943	veria-labs	36	71	1	3	1	3	2
944	veritus	37	71	1	10	1	4	2
945	vestris	31	71	1	\N	0	0	2
946	vibeflow	37	71	1	3	1	3	1
947	virtualmin	17	71	1	2	\N	1	2
948	visibl-semiconductors	35	71	1	2	2	2	2
949	voltair	35	71	1	5	1	4	2
950	voquill	34	71	1	3	0	3	1
951	voxel-energy	35	\N	1	3	1	4	2
952	voygr	35	71	1	\N	\N	2	1
953	vulcan-technologies	37	7	1	17	1	3	2
954	walter	34	71	1	\N	0	2	2
955	wardstone	36	31	1	7	1	3	2
956	wato	34	71	1	2	0	2	2
957	watsi	19	71	1	11	15	2	1
958	wave	10	26	1	1600	8	1	2
959	wayco	35	57	1	5	1	1	2
960	wealor	34	71	1	\N	0	3	2
961	weave	12	44	3	600	15	3	2
962	webflow	1	71	1	600	13	1	2
963	weebly	17	71	2	201	\N	2	2
964	wefunder	19	71	1	35	15	2	2
965	wepay	25	71	2	400	18	1	2
966	wevorce	19	72	1	11	\N	1	2
967	whatnot	30	49	1	731	7	2	1
968	whitespace	31	47	1	2	0	3	2
969	wideframe	35	71	1	2	1	3	1
970	withai	34	71	1	3	0	2	1
971	x-zell	7	75	1	19	12	0	2
972	xendit	26	38	1	700	11	3	2
973	y-combinator	\N	\N	1	100	21	1	0
974	yardbook	15	71	1	\N	\N	0	2
975	youart	34	71	1	3	1	2	2
976	zalos	36	47	1	2	1	2	2
977	zapier	3	71	1	700	15	1	2
978	zarna	36	71	1	4	1	4	2
979	zatanna	35	71	1	2	1	3	2
980	zavo	36	47	1	8	1	2	2
981	zeitview	7	49	1	200	12	0	2
982	zenbu-2	34	71	1	1	0	1	2
983	zenefits	19	71	2	500	\N	2	2
984	zenflow	7	71	1	18	12	0	2
985	zentail	3	23	1	30	15	1	2
986	zephyr-fusion	36	69	1	2	1	2	2
987	zeplin	26	71	1	140	11	4	2
988	zepto	27	50	1	1300	6	2	2
989	zerosettle	35	69	1	2	0	2	2
990	zibra-labs	34	71	1	2	0	3	2
991	zidisha	12	77	1	1	17	1	2
992	zinc	12	71	1	10	12	2	2
993	zolvo	34	71	1	3	0	2	2
994	zomma	31	71	1	5	0	3	1
995	zymbly	35	47	1	3	\N	3	1
\.


--
-- Data for Name: factfounder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.factfounder (founder_key, founder_name, company_slug, batch_key, location_key, status_key, social_count, linkedin_count, twitter_count, github_count) FROM stdin;
1	Janet Liu	oxus	35	71	1	1	1	0	0
2	Eric Zhang	sponge	35	71	1	1	1	0	0
3	Kabir Jain	inviscid-ai	35	75	1	1	1	0	0
4	Neal O'Mara	hellosign	22	71	2	1	1	0	0
5	Tiffani Ashley Bell	the-human-utility	7	71	1	2	1	1	0
6	Hung Hoang	zalos	36	47	1	1	1	0	0
7	Lewis Polansky	captain	35	71	1	2	1	1	0
8	Sanat Mishra	biostack-platforms	34	71	1	2	1	1	0
9	Ian Naccarella	83-sciences	31	71	1	1	1	0	0
10	Risely AI	risely-ai	37	71	1	1	0	1	0
11	Chalmers Brown	jarmin	36	71	1	2	1	1	0
12	Eric Zhu FounderMath @ UChicago.	axis-2	35	71	1	1	1	0	0
13	Dan Komorny	earendil-robotics	31	71	1	1	1	0	0
14	Roksana Baleshzar	tectoai	37	71	1	1	1	0	0
15	Martin Kessler	shape-shapescale	26	71	1	2	1	1	0
16	Akira Tong	arga-labs	34	71	1	2	1	1	0
17	Bryn Jones	partnerstack	26	83	2	1	0	1	0
18	Silen Naihin	experiential-labs	31	71	1	2	1	1	0
19	Jonathan Waldorf	cerenovus	31	71	1	1	1	0	0
20	Omar Jarrah	playablai	34	71	1	1	1	0	0
21	Matthew Marshall	new-story	26	5	1	1	1	0	0
22	Rishabh Chanana	os3	31	71	1	2	1	1	0
23	Devon Krapcho	cohesion	34	57	1	1	1	0	0
24	Aamir Poonawalla	understudy-labs	31	71	1	1	1	0	0
25	Sourya Majumder	projectx	34	71	1	2	1	1	0
26	Stamatios Floratos	eden-robotics	34	71	1	2	1	1	0
27	Sarah Nahm	lever	3	71	2	1	1	0	0
28	Louise Tanski	amera	36	\N	1	1	1	0	0
29	Hannah Chung	trustai	31	71	1	2	1	1	0
30	Brandon Abreu Smith	structured-ai	36	57	1	2	1	1	0
31	Kali Abeje	osmaura	31	71	1	2	1	1	0
32	Mitchell Fogelson	beyond-reach-labs	35	57	1	2	1	1	0
33	Edward Haryono	saudara-ai	34	71	1	2	1	1	0
34	Yuvan Sundrani FounderLifetime builder.	autosana	37	71	1	2	1	1	0
35	Sky Yang	imagine-ai	36	71	1	2	1	1	0
36	Hera	hera-video	37	11	1	2	2	0	0
37	Tim Trefren FounderNow working on climate change at Recheck.	mixpanel	25	71	1	2	1	1	0
38	Jon Qian Co-founder and PresidentStanford GSB Sloan Fellow.	valgo	35	71	1	1	1	0	0
39	Lorenz Neuner	finto-de	37	56	1	1	1	0	0
40	Daniel Kathein	absurd	36	49	1	2	1	1	0
41	Avi Arora	oddpool	34	71	1	2	1	1	0
42	Adam Gamieldien	certus-ai	37	71	1	2	1	1	0
43	Sergio Garcia	boom-ai	36	71	1	1	1	0	0
44	Veer Shah	cumulus-labs	35	71	1	2	1	1	0
45	Meet Modi	agentphone	34	\N	1	2	1	1	0
46	Hanbo Xie	revion	35	57	1	1	1	0	0
47	Jonathan Fishner	onecli	31	71	1	2	1	1	0
48	Jaber Jaber	rightnow	32	2	1	2	1	1	0
49	Gurish Sharma	aspect-inc	36	57	1	2	1	1	0
50	Paul Duan	bayes-impact	6	71	1	1	1	0	0
51	Dante Vaisbort	albacore-inc	37	64	1	1	1	0	0
52	Amir Elaguizy	cratejoy	1	7	1	2	1	1	0
53	FullSeam	fullseam	35	\N	1	3	3	0	0
54	Aditya Sabharwal	govguard	34	71	1	1	1	0	0
55	Benjamin Nguyen	archer	34	71	1	2	1	1	0
56	Adi Singh	ara	34	71	1	2	1	1	0
57	Arlan Rakhmetzhanov	nozomio	37	71	1	2	1	1	0
58	Jennifer Prasetyo	saudara-ai	34	71	1	2	1	1	0
59	Alex Avnit	paloma	37	71	1	1	1	0	0
60	Jonny Dimond	tasklet-2	34	71	1	2	1	1	0
61	JS Boulanger	circle-medical	26	\N	1	2	1	1	0
62	Luminal	luminal	37	71	1	3	3	0	0
63	Soren	soren	36	71	1	1	1	0	0
64	Anant Asthana	ekpa	31	15	1	1	1	0	0
65	Paul Dix	influxdata	19	57	1	2	1	1	0
66	Chawin Asavasaetakul	avoice	35	\N	1	1	1	0	0
67	Zihao Wang	pares-ai	37	49	1	1	1	0	0
68	Fabio Fleitas	tesorio	26	71	1	2	1	1	0
69	Linus Malmén	solva	37	57	1	1	1	0	0
70	Maxwell Salzberg	backerkit	3	71	1	2	1	1	0
71	Smartbase	smartbase	34	71	1	2	2	0	0
72	Rob Pruzan	zenbu-2	34	71	1	2	1	1	0
73	SellRaze	sellraze	36	71	1	2	2	0	0
74	Maceo Cardinale Kwik	datost	34	71	1	2	1	1	0
75	Aryan Vij	crow	35	71	1	2	1	1	0
76	Evan Schmidt	voxel-energy	35	\N	1	1	1	0	0
77	Shaocheng Wang	chamber	35	72	1	1	1	0	0
78	Terminal Use	terminal-use	35	71	1	3	3	0	0
79	Sven Myhre Co-founder, CTOco-founder & cto @ Ara (P26)	ara	34	71	1	2	1	1	0
80	Javier Leguina	flowscope	34	71	1	2	1	1	0
81	Pierre Depuydt	wealor	34	71	1	1	1	0	0
82	Ivan Chub	idler	37	71	1	2	1	1	0
83	AxionOrbital Space	axionorbital-space	35	71	1	2	2	0	0
84	Elena Zhao	litmus-hiring	31	57	1	2	1	1	0
85	Ilkan Gezer	zavo	36	47	1	1	1	0	0
86	Khanjan Desai	alchemy	6	90	1	1	1	0	0
87	Jeremie Cohen	kelai	34	57	1	1	1	0	0
88	Sven Myhre	ara	34	71	1	2	1	1	0
89	Tom Knight	ginkgo-bioworks	6	15	3	1	1	0	0
90	Raymond Allie	spotlight-realty	37	71	1	1	1	0	0
91	Abhisheik Sharma	protent	35	71	1	1	1	0	0
92	Corentin Hugot	kinro	34	71	1	2	1	1	0
93	Jity Woldemichael	osmaura	31	71	1	2	1	1	0
94	Eric Koslow	lattice	15	71	1	2	1	1	0
95	Crunched	crunched	36	61	1	4	4	0	0
96	Lalit Keshre	groww	4	9	3	1	1	0	0
97	Corentin Hugot FounderI am the co-founder & COO of Kinro AI.	kinro	34	71	1	2	1	1	0
98	Michelle Crosby	wevorce	19	72	1	1	1	0	0
99	Clarence Chen	travo	35	71	1	1	1	0	0
100	Bo Chen	xendit	26	38	1	1	1	0	0
101	Satya Vasanth Tumati	socratix-ai	37	71	1	2	1	1	0
102	Ludovic Granger	leadbay	36	71	1	2	1	1	0
103	Michael Lemm	andco	34	71	1	2	1	1	0
104	Divey Gulati	shipbob	6	22	1	1	1	0	0
105	Trope	trope	31	71	1	2	2	0	0
106	Shikhar Bhushan	s2-dev	36	71	1	2	1	1	0
107	Fei Deyle	lollipuff	19	71	1	1	1	0	0
108	Tanuj Siripurapu	edviro	31	71	1	2	1	1	0
109	Clement Barthes Founder - CEOex-head of autonomy at Zendar	congruent	35	71	1	1	1	0	0
110	Tony Xavier	talentpluto	31	57	1	2	1	1	0
111	Noah Helman	industrial-microbes	7	71	1	1	0	1	0
112	Jay Kwon Founder/CTOCo-founder and CTO @ Scoop.	scoop	36	71	1	1	1	0	0
113	Luc Rosenzweig	incandor	34	71	1	1	1	0	0
114	Logan Head	whatnot	30	49	1	1	1	0	0
115	Andrew Lee FounderCurrent: founder at Tasklet	tasklet-2	34	71	1	2	1	1	0
116	Mehul Agarwal	koyal	36	71	1	2	1	1	0
117	Alessia Paccagnella	vibeflow	37	71	1	2	1	1	0
118	Dylan Ma	polymath	35	71	1	1	1	0	0
119	Beacon Health	beacon-health	35	71	1	2	2	0	0
120	Charles Pan	stage	34	71	1	2	1	1	0
121	Mike Robbins	circuitlab	19	71	1	2	1	1	0
122	Sanghun Lee	aside	36	71	1	2	1	1	0
123	Sander Schulhoff	inventoryquant	35	71	1	2	1	1	0
124	Aman Mishra FounderCo-founder at Unsiloed AI • IIT Kharagpur	unsiloed-ai	36	71	1	2	1	1	0
125	Caretta	caretta	35	71	1	3	3	0	0
126	Norra	norra	36	71	1	2	2	0	0
127	Zachary Kim	wideframe	35	71	1	2	1	1	0
128	Moawia Eldeeb	tempo	7	71	1	1	1	0	0
129	Ilya Volodarsky	segment	16	71	2	1	1	0	0
130	Evan Rankin	verdex	35	71	1	1	1	0	0
131	InstaAgent	instaagent	34	71	1	2	2	0	0
132	Ezra Olubi	paystack	15	43	2	2	1	1	0
133	Steve Albarran	confident-lims	26	71	1	1	1	0	0
134	Ishan Ramrakhiani	shepherd-3	31	71	1	2	1	1	0
135	Oscar Levy	river-markets	34	71	1	1	1	0	0
136	Vaibhav Agrawal	baseframe	35	71	1	2	1	1	0
137	Jordan Khoo	greypoint-industries	31	71	1	1	1	0	0
138	Ricardo Nunez	salesgraph	34	71	1	2	1	1	0
139	Zayaan Mulla	talking-computers	35	\N	1	2	1	1	0
140	Oguzhan Atay	billiontoone	8	71	3	1	1	0	0
141	David Hua	meadow	7	71	1	2	1	1	0
142	Andrei Mihu	heroic-labs	26	47	1	1	1	0	0
143	Lawrence Gentilello	screenleap-inc	10	71	1	2	1	1	0
144	Vincent Chen	panta	35	71	1	2	1	1	0
145	Amin Hamzaoui	netter	34	71	1	1	1	0	0
146	Mazin Al-Ani	definite	31	71	1	1	1	0	0
147	Jun Kim	aside	36	71	1	2	1	1	0
148	Oleg Kostour	atlasgrid	36	71	1	2	1	1	0
149	Swen Koller	ventura	35	71	1	2	1	1	0
150	Rush Sadiwala	savahq	36	57	1	2	1	1	0
151	Kion Fallah	experiential-labs	31	71	1	2	1	1	0
152	Charu Sharma	fenrock-ai	35	71	1	2	1	1	0
153	Adam Saunders	piinpoint	12	40	1	1	1	0	0
154	Nathan Blecharczyk	airbnb	2	71	3	2	1	1	0
155	Omeed Tehrani	constellation-space	35	72	1	2	1	1	0
156	Stephen Balogh	s2-dev	36	71	1	2	1	1	0
157	Ryan Walker	general-legal	35	\N	1	2	1	1	0
158	Bryan Reed	freeport-markets	36	57	1	1	1	0	0
159	Zach Zhong	bubble-lab	35	71	1	2	1	1	0
160	Sanchit Monga	runanywhere	35	71	1	2	1	1	0
161	Chris Hood	go1	26	71	1	1	1	0	0
162	Maadhav Deekshitha	enjamb-labs	34	71	1	2	1	1	0
163	Madhav Lavakare	aircaps	36	71	1	2	1	1	0
164	Jago Wahl-Schwentker	transload	34	71	1	1	1	0	0
165	Ayman Saleh	chronicle-labs	34	71	1	2	1	1	0
166	Arushi Gandhi	ressl-ai	35	71	1	2	1	1	0
167	Zakariea Sharfeddine	inloop-robotics	34	71	1	2	1	1	0
168	Farhan Khan	shotwellai	34	71	1	1	1	0	0
169	Chris Hailey	os3	31	71	1	2	1	1	0
170	Jeff Liu	finaldose	34	47	1	1	1	0	0
171	Cole Gawin	uselemma	36	71	1	2	1	1	0
172	Rakesh Mehta	zarna	36	71	1	2	1	1	0
173	Sri Raghu Malireddi	moss	36	71	1	2	1	1	0
174	LemonLime	lemonlime	31	71	1	2	2	0	0
175	Raaid Kabir	constellation-space	35	72	1	2	1	1	0
176	David Jin Li	denki	36	71	1	1	1	0	0
177	Kwindla Hultman Kramer	daily	15	71	1	2	1	1	0
178	Jay Chooi	robocurve	31	71	1	2	1	1	0
179	Russell Smith	9-mothers-corporation	34	7	1	2	1	1	0
180	Amit Manjhi	buxfer	17	71	1	2	1	1	0
181	Ethan Boyers	semble-ai	36	71	1	1	1	0	0
182	Avoice	avoice	35	\N	1	2	2	0	0
183	Diwank Tomer	memory-store	34	71	1	2	1	1	0
184	Caitlin Swift	clara-2	34	71	1	1	1	0	0
185	Sean Wu Founderprev. NVIDIA AI & Stanford Bio Research	synphony	34	71	1	2	1	1	0
186	Hang Huang	insforge	34	71	1	2	1	1	0
187	Alexander Le Maitre	seeing-systems	35	47	1	2	1	1	0
188	Victor Ho	fivestars	22	71	2	1	1	0	0
189	Chawit Asavasaetakul	avoice	35	\N	1	2	1	1	0
190	Felipe Abello	agentcard	31	71	1	2	1	1	0
191	Pierre Betouin	tolmo	34	71	1	2	1	1	0
192	Andrew Seddon	circuithub	10	47	1	2	1	1	0
193	Aayush Naik	hypercubic	36	71	1	2	1	1	0
194	Andrew Kuik	syntropy	35	71	1	1	1	0	0
195	Heng Hong Lee	lightsprint	34	71	1	2	1	1	0
196	Matt Doka	fivestars	22	71	2	1	1	0	0
197	Jonathan Görtz	ossus	35	71	1	2	1	1	0
198	Bilal Asmatullah	sciloop	36	71	1	1	1	0	0
199	Troy Zhang	infera	34	71	1	1	1	0	0
200	Nishant Joshi	skillsync	35	71	1	2	1	1	0
201	Paula Gutierrez	selfin	36	71	1	1	1	0	0
202	Younes El hjouji	overshoot	35	71	1	1	1	0	0
203	Sudhish Swain	petrarch	31	71	1	1	1	0	0
204	Thomas Doherty	milliray	35	47	1	1	1	0	0
205	Matthias Schneider	complydo	36	12	1	1	1	0	0
206	Ishaan Makkar	hexa	34	71	1	1	1	0	0
207	Oxus	oxus	35	71	1	3	3	0	0
208	Jay Mehta	stablebrowse	34	71	1	1	1	0	0
209	Alec Howard	ruvo	37	81	1	2	1	1	0
210	Aryan Gulati	mayflower	36	71	1	2	1	1	0
211	Faizaan Chishtie	minicor	34	71	1	2	1	1	0
212	Runtime	runtime	34	71	1	2	1	1	0
213	Copperlane	copperlane	35	71	1	2	2	0	0
214	Shady Al Shoha	gpt	36	18	1	2	1	1	0
215	Eytan Rozenblum	foresight	34	57	1	1	1	0	0
216	Brian Yu	9gag	3	36	1	2	1	1	0
217	Leadbay	leadbay	36	71	1	2	2	0	0
218	Akash Pavan	chasi	35	71	1	2	1	1	0
219	Guanming Wang	general-instinct	34	71	1	2	1	1	0
220	Jordina Frances de Mas	milliray	35	47	1	1	1	0	0
221	Farhan Ur Rehman	definite	31	71	1	1	1	0	0
222	Sam Kaplan	remix-3	35	71	1	2	1	1	0
223	Oskar Kwaśniewski	testerarmy	34	71	1	2	1	1	0
224	Merih Akar	zeplin	26	71	1	2	1	1	0
225	Abhimanyu Yadav	trelium	36	71	1	2	1	1	0
226	Robin Horton	expected-parrot	36	15	1	2	1	1	0
227	Michael Dalva	travo	35	71	1	1	1	0	0
228	Beknazar Abdikamalov	speko	31	71	1	2	1	1	0
229	Paul Beckers	aquashield	34	71	1	1	1	0	0
230	Sean Cole	parasma	31	71	1	2	1	1	0
231	Abhay Kalra	avent	37	71	1	2	1	1	0
232	Dmitry Fatkhi	fastshot	36	71	1	2	1	1	0
233	Reframe	usereframe	35	71	1	2	2	0	0
234	Somansh Shah	stablebrowse	34	71	1	1	1	0	0
235	Antonio Sitong Li	noril1	31	57	1	2	1	1	0
236	Russell Smith	rainforest	3	71	1	2	1	1	0
237	Louise Broni-Mensah	shoobs	12	47	1	1	1	0	0
238	Endrit Bytyqi	codyco	36	34	1	1	1	0	0
239	Matthew Sweeny	flirtey	26	13	1	1	1	0	0
240	Mariya Nurislamova	scentbird	26	57	1	1	1	0	0
241	Zoey Zhang	flick	36	71	1	2	1	1	0
242	Long Vo	onesignal	16	71	1	2	1	1	0
243	Ai Daniil Bekirov	sparkles	35	71	1	2	1	1	0
244	Jonathan Hassan	kuli	34	71	1	1	1	0	0
245	Simon Ratner	proxy	5	71	2	2	1	1	0
246	Thomas Cesare-Herriau FounderFounder and CTO of SpotPay.	spotpay	35	71	1	1	1	0	0
247	Ryan Morrissey	hoplite	31	71	1	2	1	1	0
248	Nitesh Goel	padlet	19	71	1	1	1	0	0
249	Noah Song	archal	31	71	1	2	1	1	0
250	Stephan Wolski	lightberry	36	71	1	2	1	1	0
251	Kyle Vogt	twitch	17	71	2	1	1	0	0
252	Akshay Narisetti	pocket	35	71	1	2	1	1	0
253	Vidit Aatrey	meesho	5	9	3	1	1	0	0
254	Nate Smith	lever	3	71	2	2	1	1	0
255	Urska Srsen	bellabeat	12	71	1	1	0	1	0
256	Human Archive	human-archive	35	71	1	1	0	1	0
257	Jonah Kaye	floracene	31	57	1	1	1	0	0
258	Kerry Lu	auxos	34	71	1	2	1	1	0
259	Ryan Oldenburg	pushbullet	12	71	1	1	1	0	0
260	Emily Weiss	ditto-biosciences	35	71	1	2	1	1	0
261	Amayr Babar	nautilus	37	71	1	1	1	0	0
262	Jugoslav Petkovic	flaviar	6	46	1	1	1	0	0
263	Eden Robotics	eden-robotics	34	71	1	2	2	0	0
264	Prasanna S	rippling	18	71	1	2	1	1	0
265	Ishaan Sehgal	omnara	37	71	1	2	1	1	0
266	Wye Yew Ho	proximitty	35	71	1	2	1	1	0
267	Nirbhay Narang	aircaps	36	71	1	1	1	0	0
268	Clint Berry	weave	12	44	3	1	1	0	0
269	Geoff Segal	fullseam	35	\N	1	1	1	0	0
270	Jayram Palamadai	byteport	35	71	1	1	1	0	0
271	Azmat Habibullah	zymbly	35	47	1	2	1	1	0
272	Ansh Chokshi	mireye	31	71	1	2	1	1	0
273	Antoine Bertrand	foresight	34	57	1	1	1	0	0
274	Ines Boutemadja	klaimee	34	71	1	2	1	1	0
275	Luke Rosa	hedge	34	71	1	2	1	1	0
276	Jonathan Perichon	checkr	6	71	1	1	1	0	0
277	Szymon Rybczak	testerarmy	34	71	1	2	1	1	0
278	Dave Messina	cofactor-genomics	26	76	1	2	1	1	0
279	Rohan Mahendraker	supafax	35	71	1	2	1	1	0
280	Memory Store	memory-store	34	71	1	2	1	1	0
281	Aidan Ng	verdant	31	71	1	1	1	0	0
282	Varun Arumugam	zomma	31	71	1	1	1	0	0
283	Vishnu Sampathkumar	autumn-ai	35	71	1	2	1	1	0
284	Chris Field	clerky	16	71	1	1	1	0	0
285	Sander Schulhoff FounderHi, I'm Sander Schulhoff —	inventoryquant	35	71	1	2	1	1	0
286	Erik Meike	madrone	34	71	1	1	1	0	0
287	Gustav Bang	complir	34	71	1	1	1	0	0
288	Bhairav Mehta	characterquilt	34	71	1	1	1	0	0
289	Andrea Luzzardi	mendral	35	71	1	2	1	1	0
290	Framewise Health	framewise-health	34	71	1	2	2	0	0
291	Lucas Maddox	kyten-technologies	35	72	4	2	1	1	0
292	Colin Tseung	instaagent	34	71	1	2	1	1	0
293	Luke Shiels	interfere	37	57	1	2	1	1	0
294	Abhinai Srivastava	mashgin	7	71	1	1	1	0	0
295	James Heaney	grade	35	71	1	2	1	1	0
296	Claire Mao	instance	31	71	1	2	1	1	0
297	Forge Robotics	forge-robotics	36	71	1	2	2	0	0
298	Jonas Morgner	finto-de	37	56	1	2	1	1	0
299	Alen Rubilar-Muñoz	velum-labs	35	71	1	2	1	1	0
300	Igino Cafiero	bear-flag-robotics	4	57	2	1	1	0	0
301	David Gausebeck	matterport	10	71	3	1	1	0	0
302	Leo Gierhake	laurence	35	57	1	2	1	1	0
303	Sajeev Magesh	reasonblocks	34	71	1	1	1	0	0
304	Zayan Islam	fed10	35	71	1	1	1	0	0
305	Andrew Kurland	greentoe	6	57	1	1	1	0	0
306	Erim Gurlemis	guild	31	57	1	1	1	0	0
307	George Kalligeros	aseon-labs	34	71	1	2	1	1	0
308	Hamed Saadat	hyperpad	6	48	1	2	1	1	0
309	Alexander Bergholm	klarify	34	71	1	1	1	0	0
310	Aryan Sharma	spotlight-realty	37	71	1	1	1	0	0
311	Jae Choi	sponge	35	71	1	1	1	0	0
312	Francois Chollet	ndea-com	35	66	1	2	1	1	0
313	Cecilia Corral	caremessage	12	7	1	2	1	1	0
314	Berk Çebi	zeplin	26	71	1	2	1	1	0
315	Yash Sinha	intelligence-factory	34	71	1	1	1	0	0
316	Carmel Limcaoco	kita	35	71	1	1	1	0	0
317	Benedict Chan	lightsprint	34	71	1	2	1	1	0
318	Quan Huynh	haladir	35	71	1	2	1	1	0
319	Anand-Arnaud Pajaniradjane	scope	34	71	1	2	1	1	0
320	Andrew Lee	tasklet-2	34	71	1	2	1	1	0
321	Lucas Amlicke	synphony	34	71	1	2	1	1	0
322	Marguerite Benoist	aquashield	34	71	1	1	1	0	0
323	Kyten Technologies	kyten-technologies	35	72	4	2	2	0	0
324	Char	char	37	71	1	1	0	0	1
325	Matthew Gunton	luminal	37	71	1	2	1	1	0
326	Matthew McBrien	cohesion	34	57	1	2	1	1	0
327	Travis Kimmel	gitprime	15	29	2	1	1	0	0
328	Feroze Mohideen	robby	35	15	1	2	1	1	0
329	Peter Krogh	blue	37	71	1	1	1	0	0
330	Patrick Hannigan	hive	6	40	1	2	1	1	0
331	Conor Jones	squid	35	47	1	1	1	0	0
332	Gojiberry AI	gojiberry-ai	34	71	1	3	3	0	0
333	James Smith	hessian	34	71	1	1	1	0	0
334	Michael Nusimow	drchrono	22	71	2	1	1	0	0
335	Het Dave	andustry	34	71	1	2	1	1	0
336	John Huddleston	albacore-inc	37	64	1	1	1	0	0
337	Dafeng Guo	strikingly	19	73	1	1	1	0	0
338	Vedant Vyas	opennote	37	71	1	2	1	1	0
339	Shubham Palriwala	agnost-ai	31	71	1	2	1	1	0
340	Twolabs	twolabs	34	71	1	2	2	0	0
341	Rahul Thayil Co-Founder & CTOCo-founder at Torus (YC S26).	torus	31	71	1	1	1	0	0
342	Opennote	opennote	37	71	1	3	3	0	0
343	Brandon Moak	embark-trucks	15	71	3	1	1	0	0
344	Marvin Abdel-Massih	uplane	36	71	1	1	1	0	0
345	Hemanth Sarabu	one-robot	35	71	1	1	1	0	0
346	Jai Bhatia FounderTurning products AI-native	crow	35	71	1	2	1	1	0
347	Anderson Chen	operon	31	71	1	1	1	0	0
348	Kratik Agrawal	kinect	34	71	1	2	1	1	0
349	Niclas Heun	lunavo	36	71	1	1	1	0	0
350	Arjun Saluja	booko	35	71	1	1	1	0	0
351	Aldrin Ong	pollen	35	71	1	1	1	0	0
352	Ben Thompson	gitprime	15	29	2	2	1	1	0
353	Pollen	pollen	35	71	1	3	3	0	0
354	Prateek Mittal	crosslayer-labs	35	57	1	2	1	1	0
355	Patrick Collison	stripe	25	71	1	2	1	1	0
356	Rajiv Sancheti	caddy	36	57	1	2	1	1	0
357	Chanhee Lee	aside	36	71	1	2	1	1	0
358	John Brownell	submittable	3	55	1	1	1	0	0
359	Chris Minge	vulcan-technologies	37	7	1	1	1	0	0
360	Dhruv Saxena	shipbob	6	22	1	1	1	0	0
361	Deokhaeng Lee	char	37	71	1	2	1	1	0
362	Inigo Lenderking	luel	35	71	1	1	1	0	0
363	Jerry Wu	auxos	34	71	1	2	1	1	0
364	Seb Poole Co-Founder & CEOBuilding the AI-native ServiceNow.	modern	34	71	1	1	1	0	0
365	Kaya Celebi	guild	31	57	1	1	1	0	0
366	Wideframe	wideframe	35	71	1	2	2	0	0
367	Nico Hänggi	casey	36	71	1	1	1	0	0
368	Pedro Franceschi	brex	18	71	2	1	1	0	0
369	Brandon Leonardo	instacart	3	71	3	2	1	1	0
370	Shijie Wang	allus-ai	36	5	1	1	1	0	0
371	David Alade	sorce	36	71	1	2	1	1	0
372	George Zhai	autositu	35	\N	1	1	1	0	0
373	Rey Faustino	one-degree	12	71	1	2	1	1	0
374	Matthew Le Maitre	seeing-systems	35	47	1	1	1	0	0
375	Rihab Lajmi	asendia-ai	34	71	1	2	1	1	0
376	Rémi Bouteiller	aice	34	71	1	1	1	0	0
377	Pops	pops	34	57	1	1	0	1	0
378	Allan Shin	giveffect	7	57	1	1	1	0	0
379	Ashish Selvaraj	approxima	35	71	1	2	1	1	0
380	Kajo Kratzenstein	kugelaudio	34	71	1	1	1	0	0
381	Angel Alonso Say	resolve	7	57	1	1	1	0	0
382	Ahmad Shehu FounderCofounder and CTO @ Avelis	avelis-health	37	\N	1	2	1	1	0
383	Benjamin Muñoz-Cerro	velum-labs	35	71	1	1	1	0	0
384	Maksim Izmaylov	roomstorm	6	71	1	1	1	0	0
385	Jim Xiao	mason	15	72	1	2	1	1	0
386	Shuo Wang	deel	20	71	1	2	1	1	0
387	Convexia	convexia	37	71	1	2	2	0	0
388	Bram Schork	generalastro	35	71	1	2	1	1	0
389	Nils Börner	transload	34	71	1	2	1	1	0
390	Manu Ebert	hyperspell	36	71	1	2	1	1	0
391	Frederik Hansen	diligencesquared-inc	36	57	1	1	1	0	0
392	Drake Goodman	maywood	35	57	1	1	1	0	0
393	Yaman Ziadeh	panacea	34	71	1	1	1	0	0
394	Zachary Dermody	scheduling-wizard	35	89	1	1	1	0	0
395	Nicolò Magnante	superlog	34	71	1	2	1	1	0
396	Mike Sherrill	machine-zone	23	71	2	1	1	0	0
397	Moses Wayne	cofia	35	57	1	2	1	1	0
398	Michael Belhassen	anoria	34	71	1	2	1	1	0
399	Tine Kühnel	complir	34	71	1	1	1	0	0
400	Kartik Venkataraman	redcarpetup	26	35	1	1	1	0	0
401	Hugo Frisk	tenet-industries	34	71	1	2	1	1	0
402	Sai Vamshi Batchu	godhands	32	71	1	1	1	0	0
403	Patrick Fay	magnetic	37	71	1	1	1	0	0
404	Michael Baron	aurorin-cad	35	71	1	2	1	1	0
405	Louis Liu	rev1	35	71	1	1	1	0	0
406	Avent	avent	37	71	1	1	1	0	0
407	Eric Liu	totalis	34	71	1	2	1	1	0
408	RunAnywhere	runanywhere	35	71	1	2	2	0	0
409	Amit Yadav	fern-bot	35	\N	1	1	1	0	0
410	Chandru Shanumugasundaram	burnt	37	71	1	2	1	1	0
411	Clément Grivel	condor-energy	35	63	1	1	1	0	0
412	Melinda Liu	oxus	35	71	1	1	1	0	0
413	Curtis Liu	amplitude	10	71	3	1	1	0	0
414	Will Carkner	provenmetal	31	71	1	2	1	1	0
415	Saheed Akinbile	minicor	34	71	1	2	1	1	0
416	Mehul Agarwal FounderCEO, Koyal, Agentic AI Filmmaking	koyal	36	71	1	2	1	1	0
417	Bogdan Pyzh	9-mothers-corporation	34	7	1	1	1	0	0
418	Stephen Lake	north	19	40	2	1	1	0	0
419	Karim (Wen) Rahme	metorial	36	66	1	2	1	1	0
420	David Korn	ontora	34	71	1	2	1	1	0
421	Matteo Franceschetti	eight-sleep	26	57	1	1	1	0	0
422	Drew Houston	dropbox	9	71	3	2	1	1	0
423	Lucas Giordano	notte	37	71	1	2	1	1	0
424	LegalOS	legalos	35	71	1	3	3	0	0
425	Sam Karu	logical	36	71	1	2	1	1	0
426	Denis Mars Founder/CEO3x Founder, 3x Exits.	proxy	5	71	2	2	1	1	0
427	Edgar Pavlovsky	pentagon	34	68	1	2	1	1	0
428	Nathan Belaye	sira	37	71	1	1	1	0	0
429	matt debergalis	apollo	16	71	1	1	0	1	0
430	Amiad Soto	guesty	12	57	1	1	1	0	0
431	Amulya Balakrishnan	novaflow	37	71	1	1	1	0	0
432	Lars Gjardar Musæus	crunched	36	61	1	1	1	0	0
433	Jaihee Kim	aleph-lab	36	71	1	1	1	0	0
434	Cyrus Kelly	tdaycom	34	71	1	1	1	0	0
435	David Lee	andco	34	71	1	2	1	1	0
436	Matin Movassate	heap	19	72	2	1	1	0	0
437	Nalin Gupta	cignara	34	71	1	2	1	1	0
438	Ismaeel Bashir	expanse	34	71	1	2	1	1	0
439	Jason Gray	sunfarmer	26	39	1	2	1	1	0
440	Jiehua Wu	comena	37	34	1	1	1	0	0
441	Jakub Krzych	estimote-inc	1	42	1	2	1	1	0
442	Iba Masood	tara-ai	7	71	1	1	1	0	0
443	Matthew McClure	mux	15	71	1	1	0	1	0
444	Adnan Abbas	unsiloed-ai	36	71	1	1	1	0	0
445	Finto	finto-de	37	56	1	3	3	0	0
446	Peter Vajda	perfectbit-inc	34	71	1	1	1	0	0
447	Julius Lipp	the-company-company	34	71	1	2	1	1	0
448	Sid Rajaram	clodo	37	71	1	2	1	1	0
449	Paulina Xu	agentic-fabriq	35	71	1	2	1	1	0
450	Ahmed Aly	fabraix	31	71	1	2	1	1	0
451	Cody Stoltman	sails-co	7	7	1	1	1	0	0
452	Varun Puru	amulet	31	71	1	2	1	1	0
453	Ian Tien	mattermost	3	71	1	1	1	0	0
454	Minimal AI	minimal-ai	37	3	1	2	2	0	0
455	John Backus	cognito	6	71	2	1	0	1	0
456	Parth Patwa	biostack-platforms	34	71	1	1	1	0	0
457	Vincent Jeltsch	sitefire	35	71	1	1	1	0	0
458	Dan Keene	aseon-labs	34	71	1	2	1	1	0
459	Aliyan Ishfaq	assemble	31	71	1	2	1	1	0
460	Ali Attar	lightberry	36	71	1	2	1	1	0
461	Sudip Rokaya	lamina-labs	34	71	1	2	1	1	0
462	Ritanshu Dokania	trelium	36	71	1	2	1	1	0
463	Jerry Qian	reacher	37	71	1	2	1	1	0
464	Expected Parrot	expected-parrot	36	15	1	2	2	0	0
465	Liam McBride	useparrot	34	71	1	1	1	0	0
466	Winston Chi	noso-labs	37	71	1	1	1	0	0
467	Absurd	absurd	36	49	1	1	0	1	0
468	Girish Radhakrishnan	movedot	36	71	1	1	1	0	0
469	Luke Button	hedge	34	71	1	2	1	1	0
470	Lucy Cai	instance	31	71	1	2	1	1	0
471	Jonathan Tyshler	semble-ai	36	71	1	1	1	0	0
472	David Elskamp	lexius	35	71	1	1	1	0	0
473	Assil Halimi	apollo-atomics-inc	34	15	1	1	1	0	0
474	Winston Wei	fed10	35	71	1	1	1	0	0
475	Alex Polvi	coreos	1	71	2	1	1	0	0
476	Naren Yenuganti	polymath	35	71	1	2	1	1	0
477	Scott Gress	sails-co	7	7	1	1	1	0	0
478	Valgo	valgo	35	71	1	3	3	0	0
479	Bryce Neil	visibl-semiconductors	35	71	1	2	1	1	0
480	Shrish Janarthanan	assemble	31	71	1	2	1	1	0
481	Joe Gebbia	airbnb	2	71	3	2	1	1	0
482	Daniele Perito	faire	18	71	1	1	1	0	0
483	Olga Vidisheva	shoptiques	10	57	1	1	1	0	0
484	Nazli Danis	paloma	37	71	1	2	1	1	0
485	Sherwood Callaway	sazabi	34	71	1	2	1	1	0
486	Warren Shepard	control-seat	31	71	1	2	1	1	0
487	Kyle Chang	centralcoms	34	71	1	1	1	0	0
488	Tom Achache	unisson	35	71	1	1	1	0	0
489	Neo Lee	imagine-ai	36	71	1	2	1	1	0
490	Matthew Wong	poth-labs	31	71	1	1	1	0	0
491	Jamie Cameron	virtualmin	17	71	1	1	1	0	0
492	Yuvan Sundrani	autosana	37	71	1	2	1	1	0
493	Keyvan Moghadam	pirislabs	35	71	1	1	1	0	0
494	Neil Thanedar	labdoor	7	71	1	2	1	1	0
495	Timothy Chung	unifold	35	57	1	1	1	0	0
496	Josh Reeves	gusto	10	71	1	2	1	1	0
497	Matej Novak	eigenpal	35	71	1	2	1	1	0
498	Dan Han	aleph-lab	36	71	1	2	1	1	0
499	Cielo Nicolosi	alloovium	31	17	1	1	1	0	0
500	Somaira Punjwani	medmonk	10	54	1	1	1	0	0
501	Matthias Wolf	pairio	34	71	1	1	1	0	0
502	Gregoire Chomette	aice	34	71	1	1	1	0	0
503	Adam AlSayyad	cascade	35	71	1	2	1	1	0
504	Edith Elliott	noora-health	12	84	1	2	1	1	0
505	Fred Fooks	dayjob	34	47	1	1	1	0	0
506	Vivan Agrawal	zarna	36	71	1	1	1	0	0
507	Satya Patel	superset	34	71	1	2	1	1	0
508	Mike McNeil	sails-co	7	7	1	2	1	1	0
509	Tara Kappel	realroots	37	71	1	1	1	0	0
510	Eric Zhu	axis-2	35	71	1	1	1	0	0
511	Gatik Trivedi	lance	35	71	1	2	1	1	0
512	Edward Kim	gusto	10	71	1	2	1	1	0
513	Pete Koomen	optimizely	24	71	2	2	1	1	0
514	Yankang Yang	83-sciences	31	71	1	1	1	0	0
515	Jordan Brown	lugg	26	71	1	1	0	1	0
516	Suhail Doshi	mixpanel	25	71	1	2	1	1	0
517	Harry Zheng	youart	34	71	1	1	1	0	0
518	Maximilian Thoelen	casey	36	71	1	2	1	1	0
519	Michael Roberson	semiotic	36	71	1	2	1	1	0
520	Edison Chiu	aspect-inc	36	57	1	1	1	0	0
521	Gautam Jha	kalpa-labs	36	71	1	2	1	1	0
522	Rishi Pankhaniya	rudus	34	71	1	1	1	0	0
523	Mike Chen	magic	7	89	1	1	1	0	0
524	Amir Hanna	parrot	36	71	1	2	1	1	0
525	Grant LaFontaine	whatnot	30	49	1	1	1	0	0
526	Christian Romming	etleap	19	71	1	1	1	0	0
527	Chehir Dhaouadi	callab-ai	34	71	1	1	1	0	0
528	Robbie Bourke	zymbly	35	47	1	1	1	0	0
529	Matt Maroon	blue-frog-gaming	9	1	1	1	1	0	0
530	Thomas Dowling	fullseam	35	\N	1	2	1	1	0
531	Mathilde Collin	front	6	71	1	1	1	0	0
532	Aidan Tiruvan	archal	31	71	1	2	1	1	0
533	Julius Körfgen	uplane	36	71	1	1	1	0	0
534	Cooper McBride	kyten-technologies	35	72	4	1	1	0	0
535	Pierre-Habte Nouvellon	bravi	36	71	1	1	1	0	0
536	Mo Firouz	heroic-labs	26	47	1	1	1	0	0
537	Dan Carroll	clever	3	71	2	1	1	0	0
538	Joseph Jacob	burnt	37	71	1	2	1	1	0
539	Srihan Balaji	protent	35	71	1	2	1	1	0
540	Mod AI	mod-ai	36	71	1	2	2	0	0
541	Dr. Sabrine Obbad	alara	37	\N	1	1	1	0	0
542	C.K. Wolfe	tensr	36	71	1	2	1	1	0
543	Raphaël Dabadie	foaster	34	71	1	2	1	1	0
544	Stanley Tang	doordash	1	71	3	1	1	0	0
545	Paul Shin	f4-industries	37	71	1	2	1	1	0
546	Lewis Jones	cosmic-robotics	31	71	1	2	1	1	0
547	Jason Ong	chamber	35	72	1	1	1	0	0
548	Lucas Mantovani	velvet	36	71	1	2	1	1	0
549	Damian Szumski	skymerse	31	71	1	2	1	1	0
550	Yuga Patel	ekpa	31	15	1	1	1	0	0
551	Julia Kurnia	zidisha	12	77	1	1	1	0	0
552	Satya Patel FounderCo-founder at Superset	superset	34	71	1	2	1	1	0
553	Anushka Idamekorala	logical	36	71	1	2	1	1	0
554	Shreyans Jain	manicule	34	71	1	2	1	1	0
555	Andy Lee	deeptrace	36	71	1	1	1	0	0
556	Rafael Garcia	clever	3	71	2	2	1	1	0
557	Miranda Nover	fort	35	71	1	2	1	1	0
558	Alexandre Combes	foaster	34	71	1	2	1	1	0
559	Deep Interactions	deep-interactions	34	71	1	1	1	0	0
560	David Rabie	tovala	15	22	1	1	1	0	0
561	William Alexander	arzana	34	71	1	1	1	0	0
562	Felix Lösch	lunavo	36	71	1	1	1	0	0
563	William Schlacks	equipmentshare	7	24	3	1	1	0	0
564	Pairio	pairio	34	71	1	2	2	0	0
565	Michael Ricordeau	plivo	3	7	1	1	1	0	0
566	Tobias Herber	metorial	36	66	1	2	1	1	0
567	Liam Webster	lexius	35	71	1	1	1	0	0
568	George Kolokotronis	squid	35	47	1	1	1	0	0
569	Daniel Mukasa	abinitio-bio	34	15	1	2	1	1	0
570	Saksham Aggarwal	cardboard	35	71	1	2	1	1	0
571	Evan Meyer	mod-ai	36	71	1	1	1	0	0
572	Mojmir Horvath	poth-labs	31	71	1	1	1	0	0
573	Chase Kim	light-anchor	34	71	1	2	1	1	0
574	Iqbol Temirkhojaev	wayco	35	57	1	2	1	1	0
575	Dylan Mikus	amika	36	57	1	2	1	1	0
576	Abel John	logosguard	36	71	1	1	1	0	0
577	Alexander Stroe	patent-watch	36	83	1	1	1	0	0
578	Brendan Kellam	sourcebot	36	71	1	2	1	1	0
579	Ressl AI	ressl-ai	35	71	1	2	2	0	0
580	Aleksander Mekhanik	vulcan-technologies	37	7	1	1	1	0	0
581	Tobias Estreen	stilta	35	78	1	2	1	1	0
582	Hassan Mostafa	raspire	34	71	1	1	1	0	0
583	Kai Cui	allus-ai	36	5	1	1	1	0	0
584	Onkar Borade	lab0	34	71	1	2	1	1	0
585	Josephine Lee	palette-2	31	71	1	1	1	0	0
586	Mike Levin	drippay	34	71	1	2	1	1	0
587	Shadi Saberi	isono-health	15	71	1	1	1	0	0
588	Bryan Zin	usereframe	35	71	1	2	1	1	0
589	Beyond Reach Labs	beyond-reach-labs	35	57	1	2	2	0	0
590	Nikolai Vogler	beesafe-ai	35	71	1	1	1	0	0
591	Victor Luo FounderI help startups hire 11x engineers	perfectly	35	71	1	1	1	0	0
592	Prashant Shishodia	kalpa-labs	36	71	1	2	1	1	0
593	Sunjeet Chugh	mod-ai	36	71	1	1	1	0	0
594	George Melika	sfox	6	49	1	2	1	1	0
595	He Song	payna	35	71	1	2	1	1	0
596	Ismail Ceylan	zeplin	26	71	1	2	1	1	0
597	Julia Hudea	parrot	36	71	1	1	1	0	0
598	David Muchow	maquoketa-research	34	71	1	1	1	0	0
599	Joe Kennedy	mixy	36	\N	1	2	1	1	0
600	Saai Arora	replicas	34	71	1	2	1	1	0
601	Daniel Ajayi	sorce	36	71	1	2	1	1	0
602	Akshay Guthal	item	36	71	1	2	1	1	0
603	Carlos Volante	runtime	34	71	1	1	1	0	0
604	Laks Srini	zenefits	19	71	2	2	1	1	0
605	Ev Kontsevoy Founder/CEO- CEO/cofounder Teleport	teleport	26	71	1	2	1	1	0
606	Dirk Breeuwer	corvera	35	71	1	1	1	0	0
607	Jeff Lowe	equipmentshare	7	24	3	1	1	0	0
608	Kevin Wong	centralcoms	34	71	1	1	1	0	0
609	Luis Manrique	understudy-labs	31	71	1	2	1	1	0
610	Ahmad Khan	hex-security	35	71	1	2	1	1	0
611	Chanhyung Kim	markit	36	71	1	1	1	0	0
612	Merlin Kafka	rex-inc	31	47	1	2	1	1	0
613	Steve Messinger	perseus-defense	37	6	1	1	1	0	0
614	Simon Borrero	rappi	15	14	1	1	1	0	0
615	Rahul Vijayan	convexia	37	71	1	1	1	0	0
616	Akbar Thobhani	sfox	6	49	1	1	1	0	0
617	Warren Wijaya Wang	rebulk	37	59	1	1	1	0	0
618	Chris Farestveit	primer	36	49	1	1	1	0	0
619	Fahim Aziz	backpack	6	57	1	1	1	0	0
620	Jayden Sarveshkumar	veria-labs	36	71	1	2	1	1	0
621	Peter Tribelhorn	hera-video	37	11	1	2	1	1	0
622	Toni Lopez	karumi	36	\N	1	2	1	1	0
623	Jimmy Wei	brownie	35	71	1	1	1	0	0
624	Porsev Aslan	openroll	36	78	1	1	1	0	0
625	Barry Canton	ginkgo-bioworks	6	15	3	1	1	0	0
626	Cajal	cajal-technologies	35	71	1	2	2	0	0
627	Edgar Babajanyan	captain	35	71	1	2	1	1	0
628	InsForge	insforge	34	71	1	2	2	0	0
629	Matija Milenovic	hop-aero	31	49	1	1	1	0	0
630	William MacAskill	80-000-hours	26	47	1	1	1	0	0
631	Guy Ben Aharon	onecli	31	71	1	2	1	1	0
632	Jabbok Schlacks	equipmentshare	7	24	3	1	1	0	0
633	Joshua Wang	astraea	34	71	1	2	1	1	0
634	Quang Huynh	unifold	35	57	1	1	1	0	0
635	Atrisa	atrisa	34	71	1	3	3	0	0
636	Gauri Agarwal	koyal	36	71	1	2	1	1	0
637	Interfaze	interfaze	34	71	1	4	2	2	0
638	Amin Mokadem	amboras	34	71	1	1	1	0	0
639	Osama Jaber	rightnow	32	2	1	2	1	1	0
640	Christina Huang	ruma-care	35	71	1	1	1	0	0
641	Yahya Mokhtarzada	truebill	15	74	2	1	1	0	0
642	Adam Wiggins	heroku	23	71	2	1	1	0	0
643	Garrett Langley	flock-safety	8	5	1	1	1	0	0
644	Adam Wax	taiga	34	71	1	2	1	1	0
645	Phillip Li FounderCo-founder & CEO @ Arga Labs.	arga-labs	34	71	1	1	1	0	0
646	Armen Arakelyan	ornadyne	34	49	1	1	1	0	0
647	Tenet Industries	tenet-industries	34	71	1	3	3	0	0
648	Mukul Dhankhar	mashgin	7	71	1	1	1	0	0
649	Michael Rubin	magic	7	89	1	1	1	0	0
650	Tony Xu	doordash	1	71	3	1	1	0	0
651	Nicolas Walker	mochacare	35	71	1	1	1	0	0
652	Marcelo Cortes	faire	18	71	1	1	1	0	0
653	TesterArmy	testerarmy	34	71	1	3	0	3	0
654	Leeav Lipton	terranox-ai	35	71	1	1	1	0	0
655	Georgia Witchel	mantis	35	57	1	2	1	1	0
656	Grisa Soba	flaviar	6	46	1	1	1	0	0
657	Dimitris Pagonakis	plan0-ai	34	\N	1	1	1	0	0
658	Luigi Pederzani	manufact	37	71	1	2	1	1	0
659	Ian Christopher	qventus	7	71	1	1	1	0	0
660	Zi Zhang	proximitty	35	71	1	2	1	1	0
661	Sean O'Bannon	cranston-ai	36	71	1	2	1	1	0
662	Robert Chondro	saffron	34	71	1	2	1	1	0
663	Saahil Sundaresan	syntropy	35	71	1	2	1	1	0
664	Ayaan Parikh	convexia	37	71	1	1	1	0	0
665	Jerry Yao	saffron	34	71	1	1	1	0	0
666	Ryan Seashore	codenow	12	22	1	1	1	0	0
667	Matt Riley	fixture	35	\N	1	2	1	1	0
668	Pieter Becking	servo7	35	4	1	2	1	1	0
669	Roman Yanushevskyi	touchmark	31	71	1	2	1	1	0
670	Julian Goetze	stagewise	37	\N	1	2	1	1	0
671	Fenrock AI	fenrock-ai	35	71	1	2	2	0	0
672	Santosh Vallabhaneni	rovi-health	36	57	1	1	1	0	0
673	James Cundle	mio	15	7	1	2	1	1	0
674	Lexius	lexius	35	71	1	2	2	0	0
675	Shivani Patel	telemetron-ai	36	71	1	2	1	1	0
676	Andreas Bloomquist	chamber	35	72	1	1	1	0	0
677	Ali Tabba FounderCo-Founder & CEO @ Gravy	gravy	34	71	1	2	1	1	0
678	Ken Baylor	stealth-worker	15	71	1	1	1	0	0
679	Sam Slezek	arctic-health	34	71	1	1	1	0	0
680	Witold de La Chapelle FounderCo-Founder & CTO @ Standout	standout	34	71	1	1	1	0	0
681	Janak Sunil Co-FounderCo-Founder and CEO @ Specific	specific-labs	36	71	1	2	1	1	0
682	Louise Tanski FounderCofounder of Amera.	amera	36	\N	1	1	1	0	0
683	Lemma	uselemma	36	71	1	2	2	0	0
684	Akash Ramdas	discovered-materials	34	71	1	1	1	0	0
685	Fabian Lindfors	specific	36	78	1	1	1	0	0
686	Dave Gandy	font-awesome	26	10	1	2	1	1	0
687	Neel Sharma	sentrial	35	71	1	2	1	1	0
688	Leo Schuhmann	complydo	36	12	1	1	1	0	0
689	Koh Terai	martini	35	71	1	2	1	1	0
690	James Lindenbaum	heroku	23	71	2	1	1	0	0
691	Karen Serfaty	agentcard	31	71	1	2	1	1	0
692	Reham Fagiri	aptdeco	12	57	1	1	1	0	0
693	Ritesh Patel	the-ticket-fairy	26	49	1	2	1	1	0
694	Teo Teodosiev	emailio	12	66	1	1	1	0	0
695	Cardboard	cardboard	35	71	1	1	1	0	0
696	Hiroki Takeuchi	gocardless	16	47	1	1	1	0	0
697	Brandon Yao	semiotic	36	71	1	1	1	0	0
698	ibrahim abdu	fabraix	31	71	1	1	1	0	0
699	Jayant Kulkarni	quartzy	16	71	1	1	1	0	0
700	Anson Yu	normal	37	71	1	2	1	1	0
701	Neil Bhammar	shortkit	35	\N	1	2	1	1	0
702	Natasha Baker	snapmagic	26	71	1	2	1	1	0
703	Dev Mandal	markov	31	71	1	2	1	1	0
704	Royce Arockiasamy	pleom	37	57	1	2	1	1	0
705	Krish Iyengar FounderCo-Founder and CEO @ Pixley AI (F25)	pixley-ai	36	49	1	2	1	1	0
706	Petrus Werner	stilta	35	78	1	1	1	0	0
707	Quin Hoxie	fixture	35	\N	1	1	1	0	0
708	Stephen Xu	veria-labs	36	71	1	2	1	1	0
709	Aside	aside	36	71	1	4	2	2	0
710	Maanav Agrawal	memoir	34	71	1	1	1	0	0
711	Nalu Concepcion Foundercurrently: building RL environments.	idler	37	71	1	2	1	1	0
712	Caddy	caddy	36	57	1	2	2	0	0
713	Jacob Balaj	hop-aero	31	49	1	1	1	0	0
714	David Day	lunabill	36	71	1	1	1	0	0
715	Kanyes Thaker	hyper-4	34	71	1	2	1	1	0
716	Superset	superset	34	71	1	3	0	0	3
717	Rohan Seelamsetty	praxis-ai-2	31	71	1	2	1	1	0
718	Chad Rigetti	rigetti-computing	6	71	3	2	1	1	0
719	Rafael Garcia	kernel	37	71	1	2	1	1	0
720	Brenden Prins-McKinney	duranium	37	71	1	1	1	0	0
721	Scheduling Wizard	scheduling-wizard	35	89	1	3	3	0	0
722	Harsha Nalluru	moss	36	71	1	2	1	1	0
723	Mathias Løvring	getbalance	35	47	1	2	1	1	0
724	Tejas Agarwal	terrain	36	71	1	2	1	1	0
725	Kurt Sharma FounderCo-Founder & CTO at Burt	burt	35	71	1	2	1	1	0
726	Ronak Agarwal	6thsense	31	71	1	2	1	1	0
727	Deo Arlo (Iron Dome Guy)	arlo-industries	34	71	1	2	1	1	0
728	Milan Stankovic	leadbay	36	71	1	2	1	1	0
729	Nucleo	nucleo	36	\N	1	2	2	0	0
730	Josh Hubball	level-frames	7	57	1	2	1	1	0
731	Florian Pérocheau	condor-energy	35	63	1	1	1	0	0
732	Marcus Lima	torus	31	71	1	2	1	1	0
733	Maximiliano Casal	nowports	20	\N	1	2	1	1	0
734	Asendia AI	asendia-ai	34	71	1	2	2	0	0
735	David Kirtley	helion-energy	6	72	1	2	1	1	0
736	Philip Borge	crunched	36	61	1	1	1	0	0
737	Archit Gupta	cleartax	6	9	1	1	1	0	0
738	Eshan Dosani	perspectives-health	37	22	1	2	1	1	0
739	Mohammad Eshan	ghosteye	37	57	1	2	1	1	0
740	Emil Munk FounderEmil is a Co-founder of Balance (W26).	getbalance	35	47	1	1	1	0	0
741	Danyal Ahmad	twolabs	34	71	1	1	1	0	0
742	Vikram Chennai	ardent	34	71	1	2	1	1	0
743	Andrew Kurtz	nine-fives	34	71	1	1	1	0	0
744	Alex Mittal	fundersclub	3	71	1	2	1	1	0
745	Betsie Larkin	honeylove	14	49	1	1	1	0	0
746	Alex Bouaziz	deel	20	71	1	2	1	1	0
747	Alexander Bergholm FounderCTO @ Klarify (Batch P26)	klarify	34	71	1	1	1	0	0
748	Bryan Grisales	semiotic	36	71	1	1	1	0	0
749	Tommy Li	praxis-ai-2	31	71	1	1	1	0	0
750	Seungmin Hong	simantic	32	90	1	2	1	1	0
751	Veer Juneja	fleetline	37	57	1	1	1	0	0
752	Edward Hinson	zephyr-fusion	36	69	1	1	1	0	0
753	Dan Hyman	coasts	36	\N	1	1	1	0	0
754	Lakshya Gupta	lab0	34	71	1	2	1	1	0
755	Jared Rodman	weave	12	44	3	1	1	0	0
756	Miniswap	miniswap	36	71	1	2	2	0	0
757	Alex Rodrigues	embark-trucks	15	71	3	2	1	1	0
758	Flywheel AI	flywheel-ai	37	71	1	2	2	0	0
759	Pierre-Eliott Lallemant	gojiberry-ai	34	71	1	2	1	1	0
760	Caroline Cochran	oklo	6	71	3	2	1	1	0
761	Louis Scremin	armature	34	71	1	1	1	0	0
762	Caleb Horan	salem-robotics-inc	31	7	1	1	1	0	0
763	Cole Robertson	rebulk	37	59	1	2	1	1	0
764	Pixley AI	pixley-ai	36	49	1	2	2	0	0
765	Cashel Fitzgerald	zomma	31	71	1	1	1	0	0
766	Stephen Lin	advanced-metal-research	34	49	1	2	1	1	0
767	Aziz Hanafi	degla-inc	32	15	1	1	1	0	0
768	Nick Winter	codecombat	12	72	1	2	1	1	0
769	Carl Huang	sila	35	57	1	2	1	1	0
770	Paul Hetherington	hlabs	35	71	1	2	1	1	0
771	Sanjeev Barnwal	meesho	5	9	3	1	1	0	0
772	Nour Eldifrawy	shotwellai	34	71	1	2	1	1	0
773	Gus Trigos	runtime	34	71	1	2	1	1	0
774	Result	result	34	\N	1	2	2	0	0
775	Hursh Shah	edviro	31	71	1	2	1	1	0
776	Eugenia Kuyda	replika	7	71	1	1	1	0	0
777	Julius Scheel	transload	34	71	1	1	1	0	0
778	Xuanshu (Asher) Lin	autositu	35	\N	1	1	1	0	0
779	Luis Olave	altur	37	52	1	1	1	0	0
780	Sophia Kim	catchback-cards	35	71	1	1	1	0	0
781	Bryant Chou	ploy	34	71	1	2	1	1	0
782	Ankit Solanki	cleartax	6	9	1	1	1	0	0
783	Alex Musy	huscarl	34	71	1	1	1	0	0
784	Daniel Spokoyny	beesafe-ai	35	71	1	2	1	1	0
785	Chris Kelly	upwave	3	71	1	1	1	0	0
786	Jarrett Streebin	easypost	1	71	1	1	1	0	0
787	Veritus	veritus	37	71	1	3	3	0	0
788	Matija Rijavec	flaviar	6	46	1	1	1	0	0
789	Harshil Mathur	razorpay	7	9	1	1	0	1	0
790	Samrath Chadha	perseus	36	9	1	2	1	1	0
791	Shahryar Abbasi	risely-ai	37	71	1	1	1	0	0
792	Jerry Zhang	uselemma	36	71	1	2	1	1	0
793	Karumi	karumi	36	\N	1	2	2	0	0
794	Alex Wilcox	inkbox	31	71	1	2	1	1	0
795	Jordan Ibe	cova	31	27	1	1	1	0	0
796	Brent Burdick	confluence-labs	35	71	1	1	0	1	0
797	Gordon Wintrob	newfront-insurance	4	71	2	2	1	1	0
798	Felix Odeberg Glasenapp	elyra	34	78	1	2	1	1	0
799	Stephan Kletzl	usergems	6	8	1	1	1	0	0
800	James Baek	6thsense	31	71	1	1	1	0	0
801	Braiden Dishman	shofo	35	71	1	2	1	1	0
802	Lukas Klaiber	kaigo-health	36	71	1	1	1	0	0
803	Daichi Hiraoka	korso	34	49	1	1	1	0	0
804	Gus Levinson	getbalance	35	47	1	1	1	0	0
805	Maki Potamianos	talentpluto	31	57	1	2	1	1	0
806	Michael Gibson	voquill	34	71	1	1	1	0	0
807	Victor Vannara	trope	31	71	1	2	1	1	0
808	Saksham Gupta	levocred-ai	31	71	1	1	1	0	0
809	Irving Lin	human-dx	3	71	1	1	1	0	0
810	Imagine AI	imagine-ai	36	71	1	2	2	0	0
811	Ana Yoon Faria de Lima	pavoot	34	71	1	2	1	1	0
812	Long Hoang	martini	35	71	1	2	1	1	0
813	Naman Bansal	manicule	34	71	1	2	1	1	0
814	Shashank Kumar	razorpay	7	9	1	2	1	1	0
815	Humza Ahmed	automax-ai	36	71	1	2	1	1	0
816	Jeff Mao	sellraze	36	71	1	2	1	1	0
817	Eddy Lu	goat-group	22	49	1	1	1	0	0
818	Shakul Raj Sonker	samora-ai	35	\N	1	1	1	0	0
819	Charles Muehlberger	conifer	31	71	1	2	1	1	0
820	Luke Swanek	partnerstack	26	83	2	1	1	0	0
821	Bryan Chung	insurf	31	71	1	1	1	0	0
822	Jonah Greenberger	bright	7	57	1	1	1	0	0
823	Ben Koska	sf-tensor	36	\N	1	1	1	0	0
824	10x Science	10x-science	35	71	1	3	3	0	0
825	Ian McInnis	withai	34	71	1	2	1	1	0
826	Marc Kaa Brejner	complir	34	71	1	1	1	0	0
827	Aryaman Khanna	arden	34	71	1	2	1	1	0
828	Stephen Ni	bluma	36	71	1	2	1	1	0
829	Andre Braga	shofo	35	71	1	1	1	0	0
830	Badis Zormati	asendia-ai	34	71	1	2	1	1	0
831	Alejandro Rosas	didit	35	71	1	2	1	1	0
832	Yuta Baba	carrot-labs	35	71	1	2	1	1	0
833	Tobias Fischer	wardstone	36	31	1	1	1	0	0
834	Peyton Marcotte	perceptron-ml	31	71	1	1	1	0	0
835	Yarik Markov	voygr	35	71	1	2	1	1	0
836	Edwin Broni-Mensah	givemetap	7	47	1	1	1	0	0
837	Andres Felipe Diaz	makrwatch	7	57	1	1	1	0	0
838	Wardstone	wardstone	36	31	1	2	2	0	0
839	Gurshabd Singh Varaich	definite	31	71	1	2	1	1	0
840	Michael Moore	akkari	34	71	1	2	1	1	0
841	Bhavuk Kaul	plate-iq	26	47	1	1	1	0	0
842	Jason He	quotain	37	57	1	2	1	1	0
843	Ahmad Shehu	avelis-health	37	\N	1	2	1	1	0
844	Dennis Steele	podium	15	44	1	1	1	0	0
845	Jakub Cichon	amika	36	57	1	1	1	0	0
846	Selina Li	bubble-lab	35	71	1	2	1	1	0
847	Will Hanna	miniswap	36	71	1	1	1	0	0
848	Balance	getbalance	35	47	1	3	3	0	0
849	Alisa Rae	lucent	35	71	1	2	1	1	0
850	David Petersen	buildzoom	19	71	1	1	1	0	0
851	Anton Zaliznyi	phases	37	71	1	1	1	0	0
852	Elvira Dzhuraeva	fastshot	36	71	1	2	1	1	0
853	Pierre-Alexandre Kamienny	kinro	34	71	1	2	1	1	0
854	Lab0	lab0	34	71	1	3	3	0	0
855	Karan Raina	hyperprobe	31	71	1	1	1	0	0
856	Alberto Rosas	didit	35	71	1	2	1	1	0
857	Parker Conrad	zenefits	19	71	2	2	1	1	0
858	Leon Yao	whitespace	31	47	1	1	1	0	0
859	Benjamin Hong	daridev	36	71	1	2	1	1	0
860	Rahul Rejeev	wato	34	71	1	2	1	1	0
861	Bera Sogut	orthogonal	35	71	1	2	1	1	0
862	Luk Koska	sf-tensor	36	\N	1	1	1	0	0
863	MOVEdot	movedot	36	71	1	2	2	0	0
864	Spencer Hewett	radar	19	57	1	1	1	0	0
865	Andrea Pinto	notte	37	71	1	2	1	1	0
866	Alain Meier	cognito	6	71	2	2	1	1	0
867	Jerry Qian FounderCo-Founder and CEO @ Reacher	reacher	37	71	1	2	1	1	0
868	Jihyun Kim	zomma	31	71	1	2	1	1	0
869	Rick Harrison	meadow	7	71	1	2	1	1	0
870	Pascal Küng	casey	36	71	1	1	1	0	0
871	Shashank Pandit	buxfer	17	71	1	1	1	0	0
872	Tom Blomfield	gocardless	16	47	1	2	1	1	0
873	Alexander Schober	codyco	36	34	1	1	1	0	0
874	Kayra Bahadir	caretta	35	71	1	1	1	0	0
875	Revnu	revnu	34	71	1	2	2	0	0
876	Todd Sullivan	humoniq	37	71	1	2	1	1	0
877	Justin Kan	twitch	17	71	2	2	1	1	0
878	Max Mullen	instacart	3	71	3	2	1	1	0
879	Peter Delahunty	shoptiques	10	57	1	1	1	0	0
880	Henry A. Lee	akkari	34	71	1	1	1	0	0
881	David Tsao	billiontoone	8	71	3	1	1	0	0
882	Alex Solomon	pagerduty	11	71	3	1	1	0	0
883	Sid Menon	carson	35	71	1	2	1	1	0
884	Hudhayfa Nazoordeen	normal	37	71	1	2	1	1	0
885	Theodore Otzenberger	armature	34	71	1	2	1	1	0
886	Brandon Boehme	maven	35	71	1	2	1	1	0
887	Zatanna	zatanna	35	71	1	3	3	0	0
888	Chetan Mishra	rhizome-ai	35	57	1	1	1	0	0
889	Nick Porter	42	12	71	1	1	1	0	0
890	Borna Safabakhsh	agilemd	16	71	1	1	1	0	0
891	Eren Mendi	expanse	34	71	1	2	1	1	0
892	Michael Lin	flowmanual	31	71	1	2	1	1	0
893	Brandon Rodman	weave	12	44	3	1	1	0	0
894	Kinro	kinro	34	71	1	3	2	1	0
895	Adith Sundram	tensr	36	71	1	1	1	0	0
896	Nicholas Aldridge	mousecat	35	57	1	2	1	1	0
897	Nicholas Donahue	drafted	34	71	1	2	1	1	0
898	Brian Trautschold	ambition	12	21	1	1	1	0	0
899	Onkar Borade FounderLab0 | IITB CSE |	lab0	34	71	1	2	1	1	0
900	Dustin Curtis	svbtle	3	71	1	1	0	1	0
901	Jeffrey Yum	pollen	35	71	1	1	1	0	0
902	Otso Veisterä	the-token-company	35	71	1	2	1	1	0
903	Henry Habib	voquill	34	71	1	2	1	1	0
904	Aryah Oztanir	o11	35	71	1	2	1	1	0
905	Elias Kassell	brickwise	36	47	1	1	1	0	0
906	Lorcan O Cathain	lua-global-inc	36	47	1	1	1	0	0
907	Sahil Goel	rudus	34	71	1	2	1	1	0
908	Yolanda Cao	everest	36	71	1	2	1	1	0
909	Kaivalya Vohra	zepto	27	50	1	1	1	0	0
910	David Rusenko	weebly	17	71	2	2	1	1	0
911	Sean Grove	linzumi	34	71	1	2	1	1	0
912	Rehman Merali	teabot	26	83	1	1	1	0	0
913	Jason Cornelius	perseus-defense	37	6	1	1	1	0	0
914	Sam Stoll FounderCo-Founder & CTO at Motives. Ex-Palantir.	motives	37	47	1	1	1	0	0
915	Taylor Wakefield	teleport	26	71	1	2	1	1	0
916	Stefan Schaff	codyco	36	34	1	1	1	0	0
917	Armin Kiani	hub	34	71	1	2	1	1	0
918	Edward Ma	youart	34	71	1	1	1	0	0
919	Max Church	gravy	34	71	1	2	1	1	0
920	Advaith Sridhar	discovered-materials	34	71	1	2	1	1	0
921	Arman Kumaraswamy	the-context-company	36	71	1	2	1	1	0
922	Jon Qian	valgo	35	71	1	1	1	0	0
923	Esteban Vizcaino	maywood	35	57	1	1	1	0	0
924	Tensr	tensr	36	71	1	3	1	2	0
925	John Lai	mixerbox	12	49	1	1	1	0	0
926	Felipe Jin Li FounderApplying Explainable AI to SOX.	denki	36	71	1	1	1	0	0
927	Peter Bai	sequence-markets	35	82	1	1	1	0	0
928	o11	o11	35	71	1	2	2	0	0
929	Artem Ptashnik	chatfuel	15	71	1	1	1	0	0
930	Mike Duncan	bankjoy	7	85	1	2	1	1	0
931	Vivek Yanamadula	archer	34	71	1	2	1	1	0
932	Itay Forer	cleanly	7	57	1	2	1	1	0
933	Daniel Kasabov-Nouvion	valence	35	71	1	1	1	0	0
934	MarkIt	markit	36	71	1	2	2	0	0
935	Bill Clerico	wepay	25	71	2	1	1	0	0
936	Richard Wang	clad-labs	36	71	1	2	1	1	0
937	Jochen Madler	sitefire	35	71	1	2	1	1	0
938	Mathew Matakovic	digipals	36	71	1	2	1	1	0
939	Ai Daniil Bekirov Founder20 | 🇺🇦	sparkles	35	71	1	2	1	1	0
940	IncidentFox	brownie	35	71	1	3	2	0	1
941	Idris Mokhtarzada	truebill	15	74	2	2	1	1	0
942	Shaurya Aggarwal	florin	31	71	1	2	1	1	0
943	Drew Durbin	wave	10	26	1	2	1	1	0
944	Tony Goss	idler	37	71	1	2	1	1	0
945	Aditya Mittal	rote	33	71	1	1	1	0	0
946	Evan Yeager	maquoketa-research	34	71	1	1	1	0	0
947	Kent Goodman	maywood	35	57	1	1	1	0	0
948	Alexander Liteplo	rentahuman	34	71	1	2	1	1	0
949	Lucas Ngoo	cortex-ai	36	71	1	2	1	1	0
950	Rohan Singh	octapulse	35	\N	1	1	1	0	0
951	Pranav Bedi	moda	35	71	1	2	1	1	0
952	Nathan H. Leung	runharbor	34	71	1	2	1	1	0
953	David Haisha Chen	strikingly	19	73	1	1	1	0	0
954	Chetan Manda	mochatrade	34	71	1	2	1	1	0
955	Emil Munk	getbalance	35	47	1	1	1	0	0
956	John Collison	stripe	25	71	1	2	1	1	0
957	Emre Kaplaner	patientdeskai	35	\N	1	1	1	0	0
958	Haris Javed-Akhtar	panacea	34	71	1	1	1	0	0
959	Alan Mando	elyra	34	78	1	1	1	0	0
960	Robert Cormican	forge-robotics	36	71	1	1	1	0	0
961	Antonin Parrot	river-markets	34	71	1	2	1	1	0
962	Siddhant Paliwal FounderCo-Founder and CTO @ Specific	specific-labs	36	71	1	2	1	1	0
963	Joseph Tso	haladir	35	71	1	2	1	1	0
964	Stepan Feduniak	inloop-robotics	34	71	1	2	1	1	0
965	Leeds Rising	maximal	37	71	1	2	1	1	0
966	Zane Hengsperger	nox-metals	37	27	1	2	1	1	0
967	Clement Barthes	congruent	35	71	1	1	1	0	0
968	Lotanna Ezeike	grade	35	71	1	2	1	1	0
969	Sergio Charles	thesis	36	71	1	1	1	0	0
970	Alfonso de los Rios Villareal	nowports	20	\N	1	1	1	0	0
971	Tim Sprecher	hub	34	71	1	2	1	1	0
972	Ilariia Belova FounderFounder and CTO of Tellif AI	tell-if-ai	36	7	1	2	1	1	0
973	Selfin	selfin	36	71	1	2	2	0	0
974	Alexandros Petkos	philon	36	71	1	2	1	1	0
975	Janak Sunil	specific-labs	36	71	1	2	1	1	0
976	Fred Stevens-Smith	rainforest	3	71	1	2	1	1	0
977	Arjun Chaliha	truffle	31	57	1	2	1	1	0
978	Carly Leahy	modern-fertility	8	71	2	1	1	0	0
979	Floot	floot	37	71	1	2	2	0	0
980	Soren Biltoft-Knudsen	diligencesquared-inc	36	57	1	1	1	0	0
981	Casey	casey	36	71	1	3	3	0	0
982	Moss	moss	36	71	1	2	2	0	0
983	Mohit Gupta	levocred-ai	31	71	1	1	1	0	0
984	Ishan Sharma	cardboard	35	71	1	2	1	1	0
985	Lucas Otterling	brickanta	36	78	1	1	1	0	0
986	Rhizome AI	rhizome-ai	35	57	1	1	1	0	0
987	Naman Ambavi	oximy	35	71	1	2	1	1	0
988	Gleb Hulting	govguard	34	71	1	1	1	0	0
989	Mike Knoop	ndea-com	35	66	1	2	1	1	0
990	Avi Gotskind	voltair	35	71	1	1	1	0	0
991	Mohit Gupta FounderCo-founder & CEO at Levocred AI (YC S26).	levocred-ai	31	71	1	1	1	0	0
992	Lukas Postulka	walter	34	71	1	1	1	0	0
993	Ben Frank	general-aviation	34	71	1	2	1	1	0
994	Serena Pei	palette-2	31	71	1	2	1	1	0
995	Claire Nord	napkin-math	34	71	1	2	1	1	0
996	Eric Riesel	83-sciences	31	71	1	2	1	1	0
997	Sydney Katz	valgo	35	71	1	1	1	0	0
998	Moses Lo	xendit	26	38	1	1	1	0	0
999	Assem Chammah	gpt	36	18	1	2	1	1	0
1000	Arden	arden	34	71	1	1	1	0	0
1001	Okibi	okibi	37	71	1	2	0	2	0
1002	Riya Jagetia	socratix-ai	37	71	1	2	1	1	0
1003	Jason Steinberg FounderCo-Founder @ Autosana	autosana	37	71	1	1	1	0	0
1004	Prashant Patel	openrelay	31	72	1	1	1	0	0
1005	General Legal	general-legal	35	\N	1	3	3	0	0
1006	Stilta	stilta	35	78	1	4	4	0	0
1007	Tymek Staniszewski	lato	31	71	1	2	1	1	0
1008	Ahnaf Shahriar	simantic	32	90	1	2	1	1	0
1009	Prama Yudhistira	hex-security	35	71	1	2	1	1	0
1010	Alex Musy FounderCo-founder & CEO at Huscarl	huscarl	34	71	1	1	1	0	0
1011	Yahia Bakour	contextdev	31	71	1	2	1	1	0
1012	Debkishore Mitra	lucira-health	7	32	3	1	1	0	0
1013	Kartik Sarangmath	omnara	37	71	1	2	1	1	0
1014	Nirmit Arora	ritivel	35	71	1	2	1	1	0
1015	Andres Garza	qomplement	34	71	1	2	1	1	0
1016	Sunjeet Chugh Founder and CTOCTO @ Mod AI (F25).	mod-ai	36	71	1	1	1	0	0
1017	Boris Silver	fundersclub	3	71	1	1	1	0	0
1018	Aleem Mawani	streak	16	71	1	1	1	0	0
1019	General Astronautics	generalastro	35	71	1	1	0	1	0
1020	Shubham Malhotra	runanywhere	35	71	1	2	1	1	0
1021	George Postlethwaite	dayjob	34	47	1	1	1	0	0
1022	Akhil Sachdev	docura-health	35	71	1	2	1	1	0
1023	Saad Jamal	antigen	36	71	1	2	1	1	0
1024	Elton Shon	one-robot	35	71	1	2	1	1	0
1025	Kaan Sirin	ossus	35	71	1	1	1	0	0
1026	Derek Ye	maximal	37	71	1	1	1	0	0
1027	Ayush Garg	answerthis	36	71	1	1	1	0	0
1028	Aryan Vij FounderTurning products AI-native	crow	35	71	1	2	1	1	0
1029	Nikolas Keller	walter	34	71	1	2	1	1	0
1030	Ben Shafii	openwork	34	71	1	2	1	1	0
1031	Avi Peltz	superset	34	71	1	2	1	1	0
1032	Maximilian Arnold	ontora	34	71	1	2	1	1	0
1033	Alex Tung	whitespace	31	47	1	2	1	1	0
1034	Pamir Ehsas	moritz	35	71	1	2	1	1	0
1035	Sam Stoll	motives	37	47	1	1	1	0	0
1036	Jack Zumwalt	kimpton-ai	34	71	1	2	1	1	0
1037	Aleph Lab	aleph-lab	36	71	1	3	3	0	0
1038	Rodrigo Terán	dialogus	31	71	1	1	1	0	0
1039	Mattias Lindell	openroll	36	78	1	2	1	1	0
1040	Parth Ainampudi	kinro	34	71	1	1	1	0	0
1041	James Chen	fernstone	36	57	1	2	1	1	0
1042	Ryan Xue	andco	34	71	1	1	1	0	0
1043	Marinos Eliades	prized	31	71	1	2	1	1	0
1044	Preston Schmittou	haladir	35	71	1	1	1	0	0
1045	Eric Kreutzer	lugg	26	71	1	2	1	1	0
1046	Evan Seeyave	twentytwo	37	57	1	1	1	0	0
1047	Drew Walker	apollo-atomics-inc	34	15	1	1	1	0	0
1048	Joe Root	permutive	6	47	1	1	1	0	0
1049	Prama Yudhistira FounderCo-Founder @ Hex Security	hex-security	35	71	1	2	1	1	0
1050	Brian Chesky	airbnb	2	71	3	2	1	1	0
1051	Geoff Schmidt	apollo	16	71	1	2	1	1	0
1052	Sangha Park	light-anchor	34	71	1	2	1	1	0
1053	Alon Zuman	pops	34	57	1	2	1	1	0
1054	Lodovico Benvenuti	trellistech	34	71	1	1	1	0	0
1055	Chrisvin Jabamani	tepali	35	57	1	1	1	0	0
1056	AnswerThis	answerthis	36	71	1	2	2	0	0
1057	Samuel Gold	risklytics	31	71	1	2	1	1	0
1058	Sai Gurrapu	hypercubic	36	71	1	1	1	0	0
1059	Alexander Meek	moxion-power-co	27	71	4	1	1	0	0
1060	Ryan Petersen	flexport	12	71	1	2	1	1	0
1061	Rohan Kulkarni	ashr	35	71	1	1	1	0	0
1062	Erik Peterson	realpact	31	71	1	1	1	0	0
1063	Lee Liu	mezmo	7	53	1	1	1	0	0
1064	Raman Varma	kestrel-ai	36	71	1	1	1	0	0
1065	Zhisen An	allus-ai	36	5	1	1	1	0	0
1066	Tabish Bidiwale	openspec	35	79	1	2	1	1	0
1067	Lance Yan	traverse	35	71	1	2	1	1	0
1068	George Rose	rise-reforming	31	22	1	1	1	0	0
1069	Herman Båverud Olsson	solva	37	57	1	1	1	0	0
1070	Andres Santanilla	item	36	71	1	2	1	1	0
1071	James Burkhardt	odeko	29	57	1	1	1	0	0
1072	Joel Tomas Pimentel	selfin	36	71	1	1	1	0	0
1073	Troy Astorino	picnicai	6	71	1	1	1	0	0
1074	Rithvik Gabri	geo-ai	37	57	1	2	1	1	0
1075	Thomas Shelley	magnetic	37	71	1	2	1	1	0
1076	Jon Dahl	mux	15	71	1	2	1	1	0
1077	Chanhee Lee Co-founderCo-founder, Aside (F25)	aside	36	71	1	2	1	1	0
1078	Marshall Gould	juno-chat	34	71	1	2	1	1	0
1079	Sujay Srivastava	lab0	34	71	1	2	1	1	0
1080	Daniel Kan	cruise	12	71	2	1	1	0	0
1081	Matt Harris	dyspatch	12	87	1	1	1	0	0
1082	George Fraser	fivetran	19	71	1	1	1	0	0
1083	John Wang	zinc	12	71	1	1	1	0	0
1084	Ethan Pronev	approxima	35	71	1	2	1	1	0
1085	Dean Stratakos	stage	34	71	1	2	1	1	0
1086	Rohan Vij	reasonblocks	34	71	1	1	1	0	0
1087	Isaac Nichols	certus-ai	37	71	1	2	1	1	0
1088	Ian Wang	axis-2	35	71	1	1	1	0	0
1089	Karim Bouri	wealor	34	71	1	1	1	0	0
1090	Samuel Ladroue	netter	34	71	1	1	1	0	0
1091	Andrei Zhevlakov	hevn-inc	34	\N	1	2	1	1	0
1092	Martini	martini	35	71	1	2	2	0	0
1093	Jose Toscano	boom-ai	36	71	1	1	1	0	0
1094	Spenser Skates	amplitude	10	71	3	2	1	1	0
1095	Eduardo Velasco	silmaril	34	71	1	2	1	1	0
1096	Pavlos Markesinis	caretta	35	71	1	2	1	1	0
1097	Owen Botkin	forum	35	71	1	2	1	1	0
1098	Amol Pant	florin	31	71	1	1	1	0	0
1099	Muhammad Awan	sequence-markets	35	82	1	1	1	0	0
1100	Matthew Collins	corvera	35	71	1	2	1	1	0
1101	Ishaan Gangwani	synthetic-sciences	35	71	1	1	1	0	0
1102	Rayan Mubarak	enjamb-labs	34	71	1	2	1	1	0
1103	Paul Grech	octapulse	35	\N	1	1	1	0	0
1104	Arvid E. Gollwitzer	anto-biosciences	36	71	1	2	1	1	0
1105	Rushil Agarwal	human-archive	35	71	1	1	1	0	0
1106	Rohil Agarwal	the-context-company	36	71	1	2	1	1	0
1107	Joseph Schwarzmann	robby	35	15	1	2	1	1	0
1108	Gabe Roeloffs	zerosettle	35	69	1	2	1	1	0
1109	Alexandre Klobb	sonarly	35	71	1	2	1	1	0
1110	Apoorva Mehta	instacart	3	71	3	2	1	1	0
1111	Henrik Zillmer	airhelp	12	45	1	2	1	1	0
1112	Eli Bullock-Papa	pax-historia	35	71	1	1	1	0	0
1113	Linus Bein Fahlander	brickanta	36	78	1	1	1	0	0
1114	Connor Loi	replicas	34	71	1	2	1	1	0
1115	Abhinav Soni	bentolabs-ai	34	71	1	2	1	1	0
1116	Rick Gao	alkera-ai	31	71	1	1	1	0	0
1117	Ian Fong	chert	34	71	1	2	1	1	0
1118	Fabian Amherd	mount	34	71	1	1	1	0	0
1119	David McDonough	tdaycom	34	71	1	2	1	1	0
1120	Auri Nayak	hexa	34	71	1	1	1	0	0
1121	Mann Patira	hexa	34	71	1	1	1	0	0
1122	Venky B	plivo	3	7	1	2	1	1	0
1123	Savio Martin	result	34	\N	1	2	1	1	0
1124	Carl-Hugo Jacobsson	ossus	35	71	1	1	1	0	0
1125	Laith Altarabishi	constellation-space	35	72	1	1	1	0	0
1126	Raghav Mehrish	arctic-health	34	71	1	1	1	0	0
1127	Pranav Uppiliappan	mochacare	35	71	1	1	1	0	0
1128	Ray Wu	magicbus	15	49	1	2	1	1	0
1129	Hrishi Joshi	zarna	36	71	1	1	1	0	0
1130	Tarun Vedula	zatanna	35	71	1	2	1	1	0
1131	Seb Poole	modern	34	71	1	1	1	0	0
1132	Jean Costa de Beauregard	condor-energy	35	63	1	1	1	0	0
1133	Andy Fang	doordash	1	71	3	1	1	0	0
1134	Jack Altman	lattice	15	71	1	1	1	0	0
1135	Connor Waslo	caddy	36	57	1	2	1	1	0
1136	Hex Security	hex-security	35	71	1	3	3	0	0
1137	BeeSafe AI	beesafe-ai	35	71	1	3	3	0	0
1138	Josiah Saunders	voquill	34	71	1	2	1	1	0
1139	Janak (Crasun) Panthi	salem-robotics-inc	31	7	1	1	1	0	0
1140	Mathias Thulin	getaccept	15	71	1	2	1	1	0
1141	Huimin Xie	perfectly	35	71	1	2	1	1	0
1142	Shervin Barati	plan0-ai	34	\N	1	1	1	0	0
1143	Oussama Gabouj	compresr	35	\N	1	1	1	0	0
1144	Naren Chittem	mayflower	36	71	1	2	1	1	0
1145	Romàn Czerny	gojiberry-ai	34	71	1	2	1	1	0
1146	Louis Beaumont	screenpipe	31	71	1	2	1	1	0
1147	Imad Mokadem	amboras	34	71	1	1	1	0	0
1148	Juan Benet	protocol-labs	6	71	1	2	1	1	0
1149	Eric Berndt	tensr	36	71	1	2	1	1	0
1150	Aditya Jain	prescience-inc	31	15	1	2	1	1	0
1151	Meng Fei Shen	ruma-care	35	71	1	1	1	0	0
1152	Farhan Hossain	blue	37	71	1	2	1	1	0
1153	Agentcard	agentcard	31	71	1	2	0	2	0
1154	Naman Ambavi FounderFounder, CEO at Oximy	oximy	35	71	1	2	1	1	0
1155	Gurveer Singh	certus-ai	37	71	1	2	1	1	0
1156	Justin So	textsidekick	34	71	1	1	1	0	0
1157	Chris Molozian	heroic-labs	26	47	1	1	1	0	0
1158	Kartik Sawhney	samora-ai	35	\N	1	2	1	1	0
1159	Arya Khokhar	eos-ai	35	71	1	2	1	1	0
1160	Devin Cintron	scott-ai	36	57	1	2	1	1	0
1161	Pentagon	pentagon	34	68	1	2	1	1	0
1162	Robert Xu	fern-bot	35	\N	1	1	1	0	0
1163	Jona van Oord	rise-reforming	31	22	1	1	1	0	0
1164	Raj Patel	human-archive	35	71	1	2	1	1	0
1165	Max Church FounderCo-Founder & CTO @ Gravy.	gravy	34	71	1	2	1	1	0
1166	Michael Zhou	codag	31	71	1	2	1	1	0
1167	Shola Akinlade	paystack	15	43	2	1	1	0	0
1168	Ibrahim Rabbani	zibra-labs	34	71	1	1	1	0	0
1169	Anna Zhang	nessie	36	71	1	2	1	1	0
1170	Cathleen Kuo	opalite-health	35	71	1	2	1	1	0
1171	Uri Lopatin	pardes-bio	13	71	3	1	1	0	0
1172	Bobby Zhong FounderCo-Founder & CEO at Burt	burt	35	71	1	2	1	1	0
1173	Joseph McAllister	mousecat	35	57	1	1	1	0	0
1174	Pelin Kenez	zeplin	26	71	1	1	1	0	0
1175	Rithvik Chuppala	clodo	37	71	1	2	1	1	0
1176	Can Zehebi	zavo	36	47	1	1	1	0	0
1177	Min Jin	molagri	31	83	1	1	1	0	0
1178	Bobby Zhong	burt	35	71	1	2	1	1	0
1179	Filip Balucha	terminal-use	35	71	1	2	1	1	0
1180	Ritvik Varada	knowlify	37	71	1	1	1	0	0
1181	Pia Mancini	democracy-earth	7	51	1	1	1	0	0
1182	Vincent Park	scoop	36	71	1	1	1	0	0
1183	Mark Pothen	beacon-health	35	71	1	1	1	0	0
1184	Steve Rahimi	pango	31	78	1	2	1	1	0
1185	Aram Shatakhtsyan	modelence	37	71	1	2	1	1	0
1186	Alt-X	alt-x	35	49	1	2	2	0	0
1187	Jamie Sunderland	coasts	36	\N	1	1	1	0	0
1188	Kaushik ASP	bentolabs-ai	34	71	1	2	1	1	0
1189	Michael Marcotte	perceptron-ml	31	71	1	1	1	0	0
1190	Utkarsh Sinha	mochatrade	34	71	1	1	1	0	0
1191	Christopher Burns	inth	34	71	1	2	1	1	0
1192	Bill Jiao	general-instinct	34	71	1	2	1	1	0
1193	Lukasz Kostka	estimote-inc	1	42	1	2	1	1	0
1194	Tarun Vallabhaneni	rovi-health	36	57	1	1	1	0	0
1195	Sam Alba	mendral	35	71	1	2	1	1	0
1196	Maximiliano Casal FounderCo-founder & former COO Nowports	nowports	20	\N	1	2	1	1	0
1197	Alessia Paccagnella FounderCofounder @ VibeFlow (S25).	vibeflow	37	71	1	2	1	1	0
1198	Roger Lee	human-interest	26	71	1	2	1	1	0
1199	Rishab Luthra	sponge	35	71	1	1	1	0	0
1200	Zia Ashraf	chaldal	26	28	1	1	1	0	0
1201	Conor Jones Co-Founder / CEOCo-Founder / CEO of Squid 🦑	squid	35	47	1	1	1	0	0
1202	Mathew Matakovic FounderCTO of Digipals	digipals	36	71	1	2	1	1	0
1203	Matthew Xu	agentic-fabriq	35	71	1	2	1	1	0
1204	Jonathan Friedman	assembly	26	71	1	1	1	0	0
1205	Shaamil Karim	atlas-discovery	31	71	1	2	1	1	0
1206	Christopher Hesse	pushbullet	12	71	1	1	1	0	0
1207	Ariana Mirian	beesafe-ai	35	71	1	1	1	0	0
1208	Afton Vechery	modern-fertility	8	71	2	1	1	0	0
1209	Sean Conley	motives	37	47	1	1	1	0	0
1210	Tony Montes	zolvo	34	71	1	1	1	0	0
1211	Anish Gupta	bron	36	71	1	2	1	1	0
1212	David Merriman	magic	7	89	1	2	1	1	0
1213	Adam Hansmann	the-athletic	5	71	2	2	1	1	0
1214	Shaivi Rau	litmus-hiring	31	57	1	2	1	1	0
1215	Gordy Sun	lakonia	36	71	1	2	1	1	0
1216	Zach Zhong Founder/CTOI like to automate everything	bubble-lab	35	71	1	2	1	1	0
1217	Milind Sagaram FounderCo-Founder @ Articulate	helonic	36	71	1	1	1	0	0
1218	Jibran Hutchins	haladir	35	71	1	2	1	1	0
1219	Parsa Bahraminejad	talking-computers	35	\N	1	2	1	1	0
1220	Lihong Wang	freeport-markets	36	57	1	2	1	1	0
1221	Ralph Gootee Founder/CTOMy name is Ralph.	plangrid	10	71	2	1	1	0	0
1222	Koby Conrad	sunflower	36	71	1	2	1	1	0
1223	Yoeven D Khemlani	interfaze	34	71	1	2	1	1	0
1224	John Bachmann	mount	34	71	1	1	1	0	0
1225	Tom Hadfield	mio	15	7	1	2	1	1	0
1226	Aman Mishra	unsiloed-ai	36	71	1	2	1	1	0
1227	Geourg Kivijian	ornadyne	34	49	1	2	1	1	0
1228	Amir Elaguizy Founder/CEOCEO Cratejoy	cratejoy	1	7	1	2	1	1	0
1229	Matevž Petek	povio	12	20	1	2	1	1	0
1230	Jonathan Maynard	knowlify	37	71	1	1	1	0	0
1231	Varun Mathur	unisson	35	71	1	2	1	1	0
1232	Berkley Noble	duranium	37	71	1	1	1	0	0
1233	David Cann	double-robotics	3	71	1	1	1	0	0
1234	Sam Gorman	rivet-design	36	71	1	2	1	1	0
1235	Rishabh Dhariwal	zarna	36	71	1	1	1	0	0
1236	Jonathan van Wersch	phases	37	71	1	1	1	0	0
1237	Sarman Aulakh	chasi	35	71	1	2	1	1	0
1238	Aidan Cantu	f4-industries	37	71	1	2	1	1	0
1239	Robbie Thompson	klaus-ai	35	71	1	2	1	1	0
1240	Quentin Romero Lauro	solbrowser	36	71	1	2	1	1	0
1241	Parker Conrad	rippling	18	71	1	2	1	1	0
1242	Sanad Kiswani	playablai	34	71	1	1	1	0	0
1243	Gunin Gupta	ritivel	35	71	1	1	1	0	0
1244	Chong Shen	alchemy	6	90	1	1	1	0	0
1245	Alex Iansiti	carson	35	71	1	1	1	0	0
1246	Narayana Aaditya Ganeshkumar	skillsync	35	71	1	2	1	1	0
1247	Jerry Yao FounderBuilding AI-native technical assessments	saffron	34	71	1	1	1	0	0
1248	Humberto Evans	circuitlab	19	71	1	1	1	0	0
1249	Luke Johnston	cajal-technologies	35	71	1	2	1	1	0
1250	Spike Lipkin	newfront-insurance	4	71	2	1	1	0	0
1251	Nik Briuzgin	hevn-inc	34	\N	1	2	1	1	0
1252	Anthony Kim	savant	34	71	1	1	1	0	0
1253	Luca Menozzi	lumius	34	30	1	1	1	0	0
1254	Edvard Engesaeth	nurx	15	57	2	1	0	1	0
1255	Ismail Jeilani	brickwise	36	47	1	1	1	0	0
1256	Anshul Ahluwalia	surtr-defense-systems	34	71	1	1	1	0	0
1257	Ray Chan	9gag	3	36	1	1	1	0	0
1258	Prescience, Inc.	prescience-inc	31	15	1	2	2	0	0
1259	Moritz	moritz	35	71	1	2	2	0	0
1260	AgentPhone	agentphone	34	\N	1	2	2	0	0
1261	Shipra Jha	corelayer	35	71	1	1	1	0	0
1262	Bailey Wickham	klaus-ai	35	71	1	1	1	0	0
1263	Aaryan Kushwah	result	34	\N	1	2	1	1	0
1264	Ming Lo	teamnote	7	36	1	1	1	0	0
1265	Raban von Spiegel	emdash	35	71	1	2	1	1	0
1266	Humoniq	humoniq	37	71	1	2	2	0	0
1267	Samuel Fu	alchemize	34	71	1	2	1	1	0
1268	George Jefferson	revnu	34	71	1	2	1	1	0
1269	Steve Huffman	reddit	21	71	2	1	1	0	0
1270	Alexander Talamonti	quotain	37	57	1	2	1	1	0
1271	Rosanna Yau	backerkit	3	71	1	2	1	1	0
1272	Yaroslav Azhnyuk	petcube	15	71	1	1	1	0	0
1273	Freya	freya	37	71	1	2	2	0	0
1274	Erik Vank	usenarrative	36	71	1	1	1	0	0
1275	Zach Sims	codecademy	16	57	2	1	1	0	0
1276	Prism	tryprism	34	47	1	2	2	0	0
1277	Thomas Cesare-Herriau	spotpay	35	71	1	1	1	0	0
1278	Kevin Xie	soren	36	71	1	1	1	0	0
1279	Wasi Ahmed	maven	35	71	1	1	1	0	0
1280	Sherpa	sherpa	34	71	1	2	2	0	0
1281	Luigi Pederzani FounderCo-founder @ Manufact (fka mcp-use).	manufact	37	71	1	2	1	1	0
1282	Jeff Morin	shoptiques	10	57	1	1	1	0	0
1283	Aakar Khanna	truffle	31	57	1	2	1	1	0
1284	Austin Stone	tell-if-ai	36	7	1	1	1	0	0
1285	Aayam Bansal	synthetic-sciences	35	71	1	2	1	1	0
1286	Yaojing Huang	libra-robotics	31	71	1	1	1	0	0
1287	Adith Reddi	physical-turing	37	71	1	2	1	1	0
1288	Andustry	andustry	34	71	1	2	2	0	0
1289	Christopher Morton	cognito	6	71	2	1	1	0	0
1290	John Horton	expected-parrot	36	15	1	2	1	1	0
1291	Roman Khomenko	9-mothers-corporation	34	7	1	1	1	0	0
1292	Oskar Block	stilta	35	78	1	2	1	1	0
1293	Paul Sawaya	human-interest	26	71	1	2	1	1	0
1294	Giuseppe Rapisarda	nerviom	36	71	1	2	1	1	0
1295	Dennis Sun	ditto-biosciences	35	71	1	2	1	1	0
1296	Fern Morrison	iron-grid	37	71	1	1	1	0	0
1297	Kyle Jung	perspectives-health	37	22	1	1	1	0	0
1298	Christopher Acker	carrot-labs	35	71	1	1	1	0	0
1299	Jason Kelly	ginkgo-bioworks	6	15	3	1	1	0	0
1300	Joshua Chang	locata	37	57	1	1	1	0	0
1301	Varunram Ganesh	lapis	36	71	1	2	1	1	0
1302	Corey Berther	pollinate	35	71	1	1	1	0	0
1303	Jalaj Shukla	intelligence-factory	34	71	1	1	1	0	0
1304	Yue Dai	strand-ai	35	71	1	1	1	0	0
1305	Sanjit Menon	prana-health	35	71	1	2	1	1	0
1306	Gobhanu Sasankar Korisepati	vela	35	71	1	2	1	1	0
1307	Keenan Venuti	vector-legal	35	71	1	1	1	0	0
1308	Tim Zinkl	pairio	34	71	1	1	1	0	0
1309	Adair Borges	ditto-biosciences	35	71	1	2	1	1	0
1310	Henry Birge-Lee	crosslayer-labs	35	57	1	1	1	0	0
1311	kalam dennis	aptdeco	12	57	1	1	1	0	0
1312	Jan Sahagun FounderHey, I'm Jan.	trellistech	34	71	1	1	1	0	0
1313	Harrison Lee	meadow	7	71	1	1	1	0	0
1314	Juan Casian	boom-ai	36	71	1	1	1	0	0
1315	Fed10	fed10	35	71	1	3	3	0	0
1316	Pablo Omenaca	karumi	36	\N	1	2	1	1	0
1317	David Roberts	10x-science	35	71	1	2	1	1	0
1318	Saatvik Suryajit Korisepati	vela	35	71	1	1	1	0	0
1319	Cameron Fiore	surtr-defense-systems	34	71	1	2	1	1	0
1320	Exonic	exonic	36	71	1	2	2	0	0
1321	Perseus Defense	perseus-defense	37	6	1	2	2	0	0
1322	Samuel Oberly	scheduling-wizard	35	89	1	2	1	1	0
1323	Oluwapelumi Dada	sorce	36	71	1	2	1	1	0
1324	Ben Ong	lightsprint	34	71	1	1	1	0	0
1325	Lauren Sullivan	flightfox	3	16	1	1	1	0	0
1326	Issy Greenslade	structured-ai	36	57	1	2	1	1	0
1327	Nick Tommarello	wefunder	19	71	1	2	1	1	0
1328	Ray Xu	aemon	35	71	1	1	1	0	0
1329	Juan Gonzalez	xendit	26	38	1	1	1	0	0
1330	Siddhant Paliwal	specific-labs	36	71	1	2	1	1	0
1331	Oded Falik FounderCofounder & CTO at Strand AI	strand-ai	35	71	1	2	1	1	0
1332	Sanmay Sarada	astraea	34	71	1	1	1	0	0
1333	Samuel Mirpuri	flowscope	34	71	1	1	1	0	0
1334	Matthew Chow	trope	31	71	1	2	1	1	0
1335	Aaron Kemmer	magic	7	89	1	1	1	0	0
1336	Jacob Wright	madethis	36	71	1	2	1	1	0
1337	Ali Abid	shotwellai	34	71	1	1	1	0	0
1338	Ventura	ventura	35	71	1	2	2	0	0
1339	Mark Nazzaro	compyle	36	71	1	1	1	0	0
1340	Nikodem Bieniek	expanse	34	71	1	2	1	1	0
1341	Henry Kwan	icarus	36	49	1	2	1	1	0
1342	Pierre Betouin	sqreen	4	71	2	2	1	1	0
1343	Kalpa Labs	kalpa-labs	36	71	1	5	2	3	0
1344	Abhishek E	ressl-ai	35	71	1	2	1	1	0
1345	Jose M. Mejia Oneto	shasqi	7	71	1	1	1	0	0
1346	Matt Wulff	6thsense	31	71	1	2	1	1	0
1347	Devi Jha	trycardinal-ai	35	71	1	1	1	0	0
1348	Kai Stinchcombe	true-link	1	57	1	1	1	0	0
1349	Stephan Koenigstorfer	lightberry	36	71	1	1	1	0	0
1350	Jaden Wang	openrelay	31	72	1	1	1	0	0
1351	Marc DeVidts	double-robotics	3	71	1	1	1	0	0
1352	Jake Stevens	luminal	37	71	1	2	1	1	0
1353	Zaki GW	revion	35	57	1	2	1	1	0
1354	Muvaffak Onuş	limrun	34	71	1	2	1	1	0
1355	Uplift AI	uplift-ai	37	71	1	1	1	0	0
1356	Isabela Rodriguez	zolvo	34	71	1	1	1	0	0
1357	Aaron Chen	payna	35	71	1	2	1	1	0
1358	Mitch Duncombe	vector-legal	35	71	1	2	1	1	0
1359	Oscar Adamsson	stilta	35	78	1	1	1	0	0
1360	Ben Rubin	norra	36	71	1	1	1	0	0
1361	Amera	amera	36	\N	1	2	2	0	0
1362	Syed Ahmed	tara-ai	7	71	1	1	1	0	0
1363	Dan Sugarman	zentail	3	23	1	1	1	0	0
1364	Ilia Bolgov	touchmark	31	71	1	2	1	1	0
1365	Michael Serrano	rindler	31	15	1	2	1	1	0
1366	Deepit Shah	stablebrowse	34	71	1	2	1	1	0
1367	Ivan Zakazov	compresr	35	\N	1	2	1	1	0
1368	Miguel Lara	microhealth	26	19	1	1	1	0	0
1369	Sebastian Fischer	wardstone	36	31	1	1	1	0	0
1370	Phillip Li	arga-labs	34	71	1	1	1	0	0
1371	Perbhat Kumar	glue	35	71	1	2	1	1	0
1372	Long Yi	brownie	35	71	1	1	1	0	0
1373	Jad Bousselham	verdex	35	71	1	2	1	1	0
1374	J.P. Mohler	general-legal	35	\N	1	1	1	0	0
1375	Kartikesh Mishra	lamina-labs	34	71	1	2	1	1	0
1376	Melvin Chen	care-gp	31	80	1	2	1	1	0
1377	Noah Levy	nine-fives	34	71	1	1	1	0	0
1378	Yujong Lee	char	37	71	1	2	1	1	0
1379	Fikri San Koktas	patientdeskai	35	\N	1	1	1	0	0
1380	Kerim Taray	qomplement	34	71	1	2	1	1	0
1381	Elijah Renner	shepherd-3	31	71	1	2	1	1	0
1382	Rikin Shah	octavewealth	3	71	1	1	1	0	0
1383	Damian Chng	absurd	36	49	1	1	1	0	0
1384	Kyle Wong	instaagent	34	71	1	2	1	1	0
1385	Michael Carvin	smartasset	3	57	1	1	1	0	0
1386	Parth Radia	keyframe-labs	34	71	1	2	1	1	0
1387	Ishita Jindal	memory-store	34	71	1	2	1	1	0
1388	Socratix AI	socratix-ai	37	71	1	2	2	0	0
1389	George Deglin	onesignal	16	71	1	2	1	1	0
1390	Eric Rea	podium	15	44	1	1	1	0	0
1391	Winston Wei FounderCOO/CPO @ Fed10	fed10	35	71	1	1	1	0	0
1392	Alex Rivero	rev1	35	71	1	1	1	0	0
1393	Chase Adam	watsi	19	71	1	1	1	0	0
1394	Aum Upadhyay	silmaril	34	71	1	2	1	1	0
1395	Quanting(Daniel) xie	origami-robotics	35	71	1	2	1	1	0
1396	Tejas Viswanath	chaldal	26	28	1	1	1	0	0
1397	Travis Truett	ambition	12	21	1	1	1	0	0
1398	Rishab Jain	prescience-inc	31	15	1	2	1	1	0
1399	Alexandra Zatarain	eight-sleep	26	57	1	2	1	1	0
1400	Shirsendu Halder	jarmin	36	71	1	2	1	1	0
1401	Nikhil Nirmel	lawdingo	19	57	1	1	1	0	0
1402	Jasper van Leuven	servo7	35	4	1	1	1	0	0
1403	Elyas Obbad	alara	37	\N	1	2	1	1	0
1404	Celine Wang	robodock	35	71	1	2	1	1	0
1405	Maitreya Wagh	bolna-ai	36	9	1	2	1	1	0
1406	Emmett Shear	twitch	17	71	2	2	1	1	0
1407	Pranit Agrawal	pixley-ai	36	49	1	2	1	1	0
1408	Bao Nguyen	hessian	34	71	1	1	1	0	0
1409	Prateek Sachan	bolna-ai	36	9	1	2	1	1	0
1410	Manav Modi	agentphone	34	\N	1	2	1	1	0
1411	TakeCareOS	takecareos	34	71	1	1	1	0	0
1412	Noah Yin	pollen	35	71	1	1	1	0	0
1413	Shreyas Kaps	ashr	35	71	1	1	1	0	0
1414	Shloke Patel	human-archive	35	71	1	2	1	1	0
1415	Zac Valles	fort	35	71	1	2	1	1	0
1416	ComplyDo	complydo	36	12	1	3	3	0	0
1417	Zakaria El hjouji	overshoot	35	71	1	2	1	1	0
1418	Payna	payna	35	71	1	2	2	0	0
1419	Barnaby Malet	machine0	31	71	1	2	1	1	0
1420	Paulien Jeunesse	huscarl	34	71	1	1	1	0	0
1421	Matin Tamizi	imperfect	34	71	1	2	1	1	0
1422	Chloe Sow	infera	34	71	1	1	1	0	0
1423	Tony Li	alkera-ai	31	71	1	1	1	0	0
1424	Vineeth Kumar	samora-ai	35	\N	1	1	1	0	0
1425	Eyad Abdalla	plena-health	34	71	1	2	1	1	0
1426	Chris Fanini	weebly	17	71	2	1	1	0	0
1427	Yash Rathod	origin-bio	35	71	1	2	1	1	0
1428	Ben Brimacombe	exonic	36	71	1	2	1	1	0
1429	Zinny Weli	robodock	35	71	1	1	1	0	0
1430	Frank Wang	panta	35	71	1	2	1	1	0
1431	Ritam Rana	knowlify	37	71	1	1	1	0	0
1432	shortkit	shortkit	35	\N	1	1	1	0	0
1433	Bruno Finco	movedot	36	71	1	1	1	0	0
1434	Tom Koska	sf-tensor	36	\N	1	1	1	0	0
1435	Tim Trefren	mixpanel	25	71	1	2	1	1	0
1436	Omar Elamin	caretta	35	71	1	2	1	1	0
1437	George Favvas	clara-2	34	71	1	2	1	1	0
1438	Grace Garey	watsi	19	71	1	1	1	0	0
1439	Jonah Siegle	mixy	36	\N	1	2	1	1	0
1440	Ruma Care	ruma-care	35	71	1	2	2	0	0
1441	Ali Sareini	nautilus	37	71	1	1	1	0	0
1442	Ashton Daniel	auxos	34	71	1	2	1	1	0
1443	Huimin Xie Co-FounderBuilding the future of human careers	perfectly	35	71	1	2	1	1	0
1444	Alex Liu	korso	34	49	1	1	1	0	0
1445	Brad Siegler	equipmentshare	7	24	3	2	1	1	0
1446	Unsiloed AI	unsiloed-ai	36	71	1	2	2	0	0
1447	Varun Agarwal	envariant	35	71	1	1	1	0	0
1448	Robert Moss	valgo	35	71	1	2	1	1	0
1449	Evan Meyer Founder/CEOCEO @ Mod AI	mod-ai	36	71	1	1	1	0	0
1450	Ryan Elliott	zerosettle	35	69	1	1	1	0	0
1451	Jake Heller	casetext	1	71	2	2	1	1	0
1452	Erik Dahl	parrot	36	71	1	1	1	0	0
1453	Doug Feigelson	zinc	12	71	1	1	1	0	0
1454	Kenny Zhang	physical-turing	37	71	1	2	1	1	0
1455	Christopher Acker FounderCarrot Labs Founder.	carrot-labs	35	71	1	1	1	0	0
1456	Sardor Rahmatulloev	twolabs	34	71	1	2	1	1	0
1457	Pranit Agrawal FounderCo-founder and CTO @ Pixley AI (F25).	pixley-ai	36	49	1	2	1	1	0
1458	Laurent Perrin	front	6	71	1	2	1	1	0
1459	Stefan Kruger	lua-global-inc	36	47	1	1	1	0	0
1460	Tony Gao	fuchsia	34	71	1	2	1	1	0
1461	Liz Clarke	industrial-microbes	7	71	1	1	1	0	0
1462	Paul Huelskamp	moxion-power-co	27	71	4	1	1	0	0
1463	Grace Cimaszewski	crosslayer-labs	35	57	1	1	1	0	0
1464	Matthew Chen	laurence	35	57	1	1	1	0	0
1465	Ray Fitzgerald	trybloom	34	71	1	2	1	1	0
1466	Serafim Korablev	21st	35	71	1	2	1	1	0
1467	Brent LaRue	circle-medical	26	\N	1	2	1	1	0
1468	Amayr Babar FounderCaptain at Nautilus	nautilus	37	71	1	1	1	0	0
1469	Dominik Helmreich	clicks	36	71	1	1	1	0	0
1470	Massimo Andreasi Bassi	eight-sleep	26	57	1	1	1	0	0
1471	Keith Ryu	fountain	26	71	1	1	1	0	0
1472	Harshit Garg	lexi	36	71	1	2	1	1	0
1473	Ary Indarapu	avea-robotics	34	71	1	2	1	1	0
1474	Jim Robeson	piinpoint	12	40	1	1	1	0	0
1475	David Schlesinger	veritus	37	71	1	1	1	0	0
1476	Vivek Raja	terminal-use	35	71	1	2	1	1	0
1477	Arash Ferdowsi	dropbox	9	71	3	2	1	1	0
1478	Emil Falk	tenet-industries	34	71	1	2	1	1	0
1479	Ragav Sachdeva	takecareos	34	71	1	2	1	1	0
1480	Andrew Sy FounderBuilding Polymorph	polymorph	35	71	1	1	1	0	0
1481	Charles Ding	chamber	35	72	1	1	1	0	0
1482	Viswesh N G	canary	35	71	1	2	1	1	0
1483	Nimit Maru	savahq	36	57	1	2	1	1	0
1484	Jake Phelan	spotlight-realty	37	71	1	1	1	0	0
1485	Robert Hou	alchemize	34	71	1	1	1	0	0
1486	Zac Policzer	zibra-labs	34	71	1	1	1	0	0
1487	Aaron Coppa	fullseam	35	\N	1	1	1	0	0
1488	Norbu Sonam	sherpa	34	71	1	2	1	1	0
1489	John Ferrara	juxta	37	71	1	2	1	1	0
1490	Burt	burt	35	71	1	2	2	0	0
1491	Alex Hyungwoo Noh	6thsense	31	71	1	1	1	0	0
1492	Tunga Bayrak	freya	37	71	1	1	1	0	0
1493	Christian Kletzl	usergems	6	8	1	1	1	0	0
1494	Klaimee	klaimee	34	71	1	2	2	0	0
1495	Javed Qadruddin	general-legal	35	\N	1	1	1	0	0
1496	Todd Sullivan	flightfox	3	16	1	2	1	1	0
1497	Marshall Kools	arzana	34	71	1	1	1	0	0
1498	Sai Surbehera	lapis	36	71	1	2	1	1	0
1499	Iman Radjavi	specific	36	78	1	1	1	0	0
1500	Sayan Mitra	atrisa	34	71	1	2	1	1	0
1501	Ahmed ElShireef	outrove	37	71	1	2	1	1	0
1502	Ranvir Deshmukh	realpact	31	71	1	2	1	1	0
1503	Wade Foster	zapier	3	71	1	2	1	1	0
1504	Dan Barrett	openprose	34	71	1	2	1	1	0
1505	Panacea	panacea	34	71	1	2	2	0	0
1506	Brianna Lin	copperlane	35	71	1	2	1	1	0
1507	Kiet Ho	superset	34	71	1	2	1	1	0
1508	Klarify	klarify	34	71	1	2	2	0	0
1509	Aaron Feuer	panorama-education	1	49	1	1	1	0	0
1510	Casey Spencer	voxel-energy	35	\N	1	2	1	1	0
1511	Leon Iwanowitsch	ontora	34	71	1	2	1	1	0
1512	Darby Wong	clerky	16	71	1	2	1	1	0
1513	Sidra Qasim	markhor	26	71	1	2	1	1	0
1514	Jigar Patel	the-ticket-fairy	26	49	1	1	1	0	0
1515	Aoden Teo	miso-labs	34	71	1	1	1	0	0
1516	Will Hall	booko	35	71	1	1	1	0	0
1517	Cole Dermott	locus	36	70	1	2	1	1	0
1518	Haz Hubble	pally	37	71	1	2	1	1	0
1519	Pedro Fernández	altur	37	52	1	1	1	0	0
1520	Oncel Ozgul	patientdeskai	35	\N	1	1	1	0	0
1521	Rounak Adhikary	projectx	34	71	1	2	1	1	0
1522	Jonathan Tang	vastrm	3	71	1	1	1	0	0
1523	Zsika Phillip	spotpay	35	71	1	1	1	0	0
1524	Perfectly	perfectly	35	71	1	3	3	0	0
1525	Armand Iorgulescu	fed10	35	71	1	2	1	1	0
1526	Payton Case	dispatch	34	71	1	1	1	0	0
1527	Sarth Garg	valctrl	34	57	1	2	1	1	0
1528	Henrique Dubugras	brex	18	71	2	2	1	1	0
1529	Tom Harari	cleanly	7	57	1	2	1	1	0
1530	Hudson Liao	the-hog	36	70	1	2	1	1	0
1531	Chamber	chamber	35	72	1	4	4	0	0
1532	Parth Maheshwari	mochatrade	34	71	1	2	1	1	0
1533	Aubrey Donnellan	bear-flag-robotics	4	57	2	1	1	0	0
1534	Rahul Thayil	torus	31	71	1	1	1	0	0
1535	Tanner Jones	vulcan-technologies	37	7	1	2	1	1	0
1536	Samir Smajic	getaccept	15	71	1	1	1	0	0
1537	Julien Lemoine	algolia	12	71	1	2	1	1	0
1538	Pavel Mitsevich	hevn-inc	34	\N	1	2	1	1	0
1539	Lucas Zubillaga	rise-reforming	31	22	1	1	1	0	0
1540	Corelayer	corelayer	35	71	1	2	2	0	0
1541	Hai Ta	userlens	34	71	1	2	1	1	0
1542	Jermaine Zhao	libra-robotics	31	71	1	1	1	0	0
1543	Axel La Pira	tryprism	34	47	1	1	1	0	0
1544	Jade Checlair	terranox-ai	35	71	1	1	1	0	0
1545	Gary Gao	chert	34	71	1	2	1	1	0
1546	Ketan Agrawal	carson	35	71	1	2	1	1	0
1547	Arthur Zhou	valence	35	71	1	1	1	0	0
1548	William Fairbairn	zalos	36	47	1	1	1	0	0
1549	Milind Sagaram	helonic	36	71	1	1	1	0	0
1550	Jonathan Mendes	partnerstack	26	83	2	1	1	0	0
1551	Takuya Norisugi	jinba	35	\N	1	2	1	1	0
1552	Jordon Kashanchi	visibl-semiconductors	35	71	1	1	1	0	0
1553	Sri Somasundaram	deeptrace	36	71	1	1	1	0	0
1554	Amika	amika	36	57	1	2	2	0	0
1555	Isaac Tolley	juno-chat	34	71	1	2	1	1	0
1556	Shiv Kampani	autumn-ai	35	71	1	2	1	1	0
1557	Mixy	mixy	36	\N	1	2	2	0	0
1558	Vishnu Tejus	10x-science	35	71	1	2	1	1	0
1559	Santiago Siri	democracy-earth	7	51	1	1	1	0	0
1560	Russell Varriale	resolve	7	57	1	2	1	1	0
1561	Warren Weissbluth	voltair	35	71	1	1	1	0	0
1562	Peter Bai FounderI LOVE MARKETS RAHHHH	sequence-markets	35	82	1	1	1	0	0
1563	Asaph Kupferman	floracene	31	57	1	1	1	0	0
1564	Shubham Palriwala Founderco-founder and ceo of agnost ai.	agnost-ai	31	71	1	2	1	1	0
1565	Ryan McCarroll	answerthis	36	71	1	1	1	0	0
1566	Adrian Kilian	mango-medical-inc	35	\N	1	2	1	1	0
1567	Agnay Srivastava	tsenta	31	71	1	2	1	1	0
1568	Zhuang (Gary) Luo	perfectly	35	71	1	1	1	0	0
1569	Joseph Zhang	catchback-cards	35	71	1	2	1	1	0
1570	David Maulick	scott-ai	36	57	1	2	1	1	0
1571	Reid Rubsamen	immunity-project	12	71	1	1	1	0	0
1572	Digipals	digipals	36	71	1	1	1	0	0
1573	Tracy Young	plangrid	10	71	2	1	1	0	0
1574	Haluk Cem Demirhan	cascade	35	71	1	1	1	0	0
1575	Tamzid Razzaque	sigmanticai	37	71	1	1	1	0	0
1576	Jynnie Tang	napkin-math	34	71	1	1	1	0	0
1577	Tony Chang	insforge	34	71	1	2	1	1	0
1578	Victor Luo	perfectly	35	71	1	1	1	0	0
1579	Clovis Piedallu	tornyol	36	63	1	2	1	1	0
1580	s2.dev	s2-dev	36	71	1	5	3	1	1
1581	Wei Deng	clipboard	18	71	1	1	1	0	0
1582	Sean Cole FounderFounder at Parasma (YC S26)	parasma	31	71	1	2	1	1	0
1583	Claire Jutabha	legalos	35	71	1	1	1	0	0
1584	Oliver Knapp	clicks	36	71	1	1	1	0	0
1585	Max Minsker	cranston-ai	36	71	1	2	1	1	0
1586	Sean Wu	synphony	34	71	1	2	1	1	0
1587	Michael Sukkarieh	sourcebot	36	71	1	2	1	1	0
1588	Nic Novak	magic	7	89	1	1	1	0	0
1589	Adeep Mitra	pollinate	35	71	1	2	1	1	0
1590	Tom Watson	hessian	34	71	1	1	1	0	0
1591	Shailendra Singh	hyperprobe	31	71	1	1	1	0	0
1592	Raymond Zhao	structured-ai	36	57	1	2	1	1	0
1593	Harsha Vardhan Khurdula	interfaze	34	71	1	2	1	1	0
1594	Vedant Singh	salus	35	71	1	2	1	1	0
1595	Bloom	trybloom	34	71	1	1	0	1	0
1596	Steven Lin	finaldose	34	47	1	1	1	0	0
1597	David Lomelin	arden	34	71	1	1	1	0	0
1598	Matt Munns	cohesion	34	57	1	1	1	0	0
1599	Ayush Patel	osseus	31	\N	1	1	1	0	0
1600	Anirudh Pupneja	redapto	36	71	1	2	1	1	0
1601	Andrew Barnes	go1	26	71	1	1	1	0	0
1602	Ali Abdalla	shotwellai	34	71	1	2	1	1	0
1603	Modelence	modelence	37	71	1	1	0	1	0
1604	Madrone	madrone	34	71	1	2	2	0	0
1605	Viktor Presber	kugelaudio	34	71	1	1	1	0	0
1606	Winston Chi Founder2x founder, love building Vertical AI	noso-labs	37	71	1	1	1	0	0
1607	Joshua March	veritus	37	71	1	2	1	1	0
1608	Mohammed Al-Rasheed	moda	35	71	1	2	1	1	0
1609	Sahil Seth	talentpluto	31	57	1	2	1	1	0
1610	Joe Ariel	goldbelly	19	57	1	1	1	0	0
1611	Trellis	trellistech	34	71	1	2	2	0	0
1612	Jash Mota	flywheel-ai	37	71	1	2	1	1	0
1613	Neeraj Singh	groww	4	9	3	1	1	0	0
1614	Austin Che	ginkgo-bioworks	6	15	3	1	1	0	0
1615	Ahmad Khan FounderCo-Founder, Hex Security.	hex-security	35	71	1	2	1	1	0
1616	qomplement	qomplement	34	71	1	2	2	0	0
1617	Joshua Augustin	tempo	7	71	1	1	1	0	0
1618	Mith Paresh Patel	sila	35	57	1	2	1	1	0
1619	Steve Heffernan	mux	15	71	1	2	1	1	0
1620	Kiet Ho FounderCo-Founder at Superset	superset	34	71	1	2	1	1	0
1621	Noga Leviner	picnicai	6	71	1	1	1	0	0
1622	Robert Chondro Founder / CEOCEO	saffron	34	71	1	2	1	1	0
1623	Zaid Qureshi	uplift-ai	37	71	1	2	1	1	0
1624	Armin Kiani FounderCS & robotics.	hub	34	71	1	2	1	1	0
1625	Chia-Lun Wu	hera-video	37	11	1	2	1	1	0
1626	Clint Burgess	characterquilt	34	71	1	2	1	1	0
1627	Jordan Zietz	lemonlime	31	71	1	2	1	1	0
1628	Elia Saquand	vibeflow	37	71	1	1	1	0	0
1629	Catherine Jue	kernel	37	71	1	2	1	1	0
1630	Lucas Tucker	velvet	36	71	1	1	1	0	0
1631	Eric Levine	clawvisor	34	71	1	2	1	1	0
1632	Alexander Calafiura	travo	35	71	1	1	1	0	0
1633	Jason Zhan	memoir	34	71	1	1	1	0	0
1634	Aadit Palicha	zepto	27	50	1	1	1	0	0
1635	Cameron Spiller	soria	34	57	1	1	1	0	0
1636	Dima Vremenko	inkbox	31	71	1	2	1	1	0
1637	Ziming Qiu	inviscid-ai	35	75	1	1	1	0	0
1638	Kevin Shin	giveffect	7	57	1	1	1	0	0
1639	Glenn Töws	stagewise	37	\N	1	2	1	1	0
1640	Mauricio Ortiz	kimpton-ai	34	71	1	2	1	1	0
1641	Manuel Castro	napkin-math	34	71	1	2	1	1	0
1642	Gohar Tamrazyan	pavoot	34	71	1	2	1	1	0
1643	Nicolas Dessaigne	algolia	12	71	1	2	1	1	0
1644	Primer	primer	36	49	1	2	2	0	0
1645	Javier Leguina Founder2x founder	flowscope	34	71	1	2	1	1	0
1646	Nikos Dritsakos	glen	31	71	1	2	1	1	0
1647	Rachel Asir	legalos	35	71	1	1	1	0	0
1648	Sarah Smith	bodyport	26	71	1	1	1	0	0
1649	Sadia Saifuddin	risely-ai	37	71	1	2	1	1	0
1650	Ojas Kandhare	opentrade	31	72	1	2	1	1	0
1651	Naveen Jain	immunity-project	12	71	1	1	1	0	0
1652	Pietro Zullo	manufact	37	71	1	2	1	1	0
1653	Andy Moon	sunfarmer	26	39	1	2	1	1	0
1654	Travis Chase	font-awesome	26	10	1	2	1	1	0
1655	Sam Lushtak	palus-finance	35	\N	1	2	1	1	0
1656	Dorothy Li	realroots	37	71	1	1	1	0	0
1657	Alex Levy	numerion-labs	7	71	1	1	1	0	0
1658	Meer Patel	prana-health	35	71	1	2	1	1	0
1659	David van Dijk	celltype	35	57	1	2	1	1	0
1660	Sruthi Viswanathan	deep-interactions	34	71	1	2	1	1	0
1661	Soria	soria	34	57	1	1	1	0	0
1662	Efrain Torres	adialante	34	71	1	1	1	0	0
1663	Prerit Oberai	prototypingio	34	71	1	2	1	1	0
1664	Parth Ajmera	agnost-ai	31	71	1	2	1	1	0
1665	Joseph Thomas	forum	35	71	1	2	1	1	0
1666	Ray Liao	inkbox	31	71	1	2	1	1	0
1667	Alec Olesky	rowflow	37	57	1	1	1	0	0
1668	Sukrut Oak	logosguard	36	71	1	2	1	1	0
1669	Specific Labs	specific-labs	36	71	1	2	2	0	0
1670	Taira Fujioka	smartbase	34	71	1	2	1	1	0
1671	Peter Chien	kaigo-health	36	71	1	1	1	0	0
1672	Sebastian Mejia	rappi	15	14	1	2	1	1	0
1673	Karim Bouri FounderCofounder & CEO @ Wealor	wealor	34	71	1	1	1	0	0
1674	Gianluca Bencomo	efference	36	71	1	2	1	1	0
1675	Kaahan Radia	keyframe-labs	34	71	1	2	1	1	0
1676	Joe Fioti	luminal	37	71	1	2	1	1	0
1677	Dwarak Govind Parthiban	s2-dev	36	71	1	2	1	1	0
1678	Hudson Griffith	prized	31	71	1	2	1	1	0
1679	Francisco Serra-Martins	isengard-industries-inc	31	33	1	2	1	1	0
1680	Hayden Gosch	voltair	35	71	1	1	1	0	0
1681	Martin Pan	korso	34	49	1	1	1	0	0
1682	Bright Xu	aspect-inc	36	57	1	2	1	1	0
1683	Paul Schneider	fort	35	71	1	2	1	1	0
1684	Richard Zhou	aemon	35	71	1	1	1	0	0
1685	Zander Schweitzer	alloovium	31	17	1	2	1	1	0
1686	Rohil Khare	sigmanticai	37	71	1	1	1	0	0
1687	art freebrey	revnu	34	71	1	2	1	1	0
1688	Adam Brown	mux	15	71	1	1	1	0	0
1689	Joel Gillman	goldbelly	19	57	1	2	1	1	0
1690	Almo Sutedjo	comena	37	34	1	1	1	0	0
1691	Niranjan Baskaran	confluence-labs	35	71	1	1	1	0	0
1692	Titus Ex	minimal-ai	37	3	1	1	1	0	0
1693	Joon Won Song	instinct-xyz	35	71	1	2	1	1	0
1694	AtlasGrid	atlasgrid	36	71	1	3	3	0	0
1695	Luigi Charles	thesis	36	71	1	1	1	0	0
1696	Eunju Moon	instinct-xyz	35	71	1	1	1	0	0
1697	Jai Bhatia	crow	35	71	1	2	1	1	0
1698	Vansh Ramani	ramain	35	71	1	2	1	1	0
1699	Ditto Biosciences	ditto-biosciences	35	71	1	3	3	0	0
1700	Freddy Vega	platzi	7	71	1	2	1	1	0
1701	Spencer McKee	everest	36	71	1	2	1	1	0
1702	Abdelrahman Hamimi	scheduling-wizard	35	89	1	1	1	0	0
1703	Ruhan Ponnada	salesgraph	34	71	1	2	1	1	0
1704	Tario You	opentrade	31	72	1	1	1	0	0
1705	Rithik Jain	atrisa	34	71	1	2	1	1	0
1706	Ralph Gootee	plangrid	10	71	2	1	1	0	0
1707	Phillip Wei	openinvest	26	71	2	2	1	1	0
1708	Niosha Afsharikia, PhD	tectoai	37	71	1	2	1	1	0
1709	Peggy Wang	digipals	36	71	1	2	1	1	0
1710	Felipe Villamarin	rappi	15	14	1	1	1	0	0
1711	Alex Mehregan	opalite-health	35	71	1	2	1	1	0
1712	Ara	ara	34	71	1	2	2	0	0
1713	Alexandre Wayenberg	shape-shapescale	26	71	1	1	1	0	0
1714	Dev Karpe	praxis-ai-2	31	71	1	1	1	0	0
1715	Sol	solbrowser	36	71	1	2	0	2	0
1716	Voxel Energy	voxel-energy	35	\N	1	3	3	0	0
1717	Daniel Pearson	wideframe	35	71	1	2	1	1	0
1718	Dasmer Singh	allowance	34	71	1	2	1	1	0
1719	Albert Cai	runharbor	34	71	1	1	1	0	0
1720	Ahmed Beshry	caper	15	\N	2	1	1	0	0
1721	Savio Martin Co-Founder & CTO19, Co-founder & CTO, Result.	result	34	\N	1	2	1	1	0
1722	Alexander Risio	risklytics	31	71	1	2	1	1	0
1723	TectoAI	tectoai	37	71	1	2	2	0	0
1724	Bravi	bravi	36	71	1	2	2	0	0
1725	Alex Southmayd	bloomy	31	71	1	2	1	1	0
1726	Zack Leman	jarmin	36	71	1	2	1	1	0
1727	Angel Onuoha	avelis-health	37	\N	1	2	1	1	0
1728	Sean Bolton	end-close	35	\N	1	2	1	1	0
1729	Max Pfeiffer	voxel-energy	35	\N	1	1	1	0	0
1730	James Tennant	isengard-industries-inc	31	33	1	1	1	0	0
1731	Foreman	foreman	35	71	1	1	1	0	0
1732	Zak Singh	miniswap	36	71	1	1	1	0	0
1733	Luca Pegolotti	nucleo	36	\N	1	1	1	0	0
1734	Kevin Le	clad-labs	36	71	1	2	1	1	0
1735	Athan Zhang	copperlane	35	71	1	2	1	1	0
1736	Saif Elhager	outrove	37	71	1	1	1	0	0
1737	Tiger Wang	nessie	36	71	1	2	1	1	0
1738	Ankur Dahama	userlens	34	71	1	2	1	1	0
1739	Revanth Bodepudi	prototypingio	34	71	1	2	1	1	0
1740	Jack Beecher	denta	31	71	1	2	1	1	0
1741	Wyatt Lansford	pally	37	71	1	2	1	1	0
1742	Scott AI	scott-ai	36	57	1	3	2	1	0
1743	Angelica Iacovelli	nucleo	36	\N	1	2	1	1	0
1744	Mahyad Ghassemi	okibi	37	71	1	2	1	1	0
1745	Samika Sanghvi	minro	36	71	1	2	1	1	0
1746	Stefan Mandaric	moritz	35	71	1	1	1	0	0
1747	Alec Olesky FounderCo-founder at RowFlow.	rowflow	37	57	1	1	1	0	0
1748	Albacore Inc.	albacore-inc	37	64	1	2	2	0	0
1749	Marc Zoghby FounderCo-founder @ Bron	bron	36	71	1	2	1	1	0
1750	Jack Grodnick	control-seat	31	71	1	1	1	0	0
1751	James Wall	phases	37	71	1	1	1	0	0
1752	Samuel Mirpuri FounderMcKinsey (QuantumBlack)	flowscope	34	71	1	1	1	0	0
1753	Abhi Arya	opennote	37	71	1	2	1	1	0
1754	Shoya Matsumori	jinba	35	\N	1	2	1	1	0
1755	Userlens	userlens	34	71	1	2	2	0	0
1756	Jianna Liu	trycardinal-ai	35	71	1	1	1	0	0
1757	Philip Meng	shepherd-3	31	71	1	2	1	1	0
1758	Ian Lee	petrarch	31	71	1	1	1	0	0
1759	Daniela Muñoz	lemonlime	31	71	1	2	1	1	0
1760	Edward Look	floot	37	71	1	2	1	1	0
1761	Jared Friedman	scribd	28	71	1	1	1	0	0
1762	Deep Kapur	amera	36	\N	1	2	1	1	0
1763	Jessica Livingston	y-combinator	\N	\N	1	2	1	1	0
1764	Vineet Jammalamadaka	robby	35	15	1	1	1	0	0
1765	Teng Bao	strikingly	19	73	1	1	1	0	0
1766	Seiji Yamamoto	perfectbit-inc	34	71	1	1	1	0	0
1767	Ansh Tandon	cova	31	27	1	2	1	1	0
1768	Chen Atlas	cleanly	7	57	1	1	1	0	0
1769	Kamel Charaf	compresr	35	\N	1	2	1	1	0
1770	Michael Sakowski	crunched	36	61	1	1	1	0	0
1771	Jai Relan	relling	37	71	1	2	1	1	0
1772	Andreas Stroe	patent-watch	36	83	1	1	1	0	0
1773	Hamza Al-Ali	playablai	34	71	1	2	1	1	0
1774	James Walton	earendil-robotics	31	71	1	1	1	0	0
1775	Bo Lu	futureadvisor	11	71	2	2	1	1	0
1776	Ashwin Sriram	travo	35	71	1	1	1	0	0
1777	Aris Zhu	robocurve	31	71	1	1	1	0	0
1778	Dmitrii Dumik	chatfuel	15	71	1	1	1	0	0
1779	Max Rhodes	faire	18	71	1	1	1	0	0
1780	John Jeong	char	37	71	1	2	1	1	0
1781	Lakonia	lakonia	36	71	1	2	2	0	0
1782	Julian Fried	advanced-metal-research	34	49	1	2	1	1	0
1783	Pedro Nobre	cajal-technologies	35	71	1	1	1	0	0
1784	Moritz Moser	complydo	36	12	1	1	1	0	0
1785	Felipe Jin Li	denki	36	71	1	1	1	0	0
1786	Carl Carell	getaccept	15	71	1	1	1	0	0
1787	Abdullah Nauman	antigen	36	71	1	2	1	1	0
1788	Ian Wang FounderYale '25	axis-2	35	71	1	1	1	0	0
1789	Vishnu Pathmanaban	tepali	35	57	1	1	1	0	0
1790	Linus Boehm	finto-de	37	56	1	1	1	0	0
1791	Michael Mason	ruvo	37	81	1	1	1	0	0
1792	Tomas Nepala	freya	37	71	1	2	1	1	0
1793	Ilariia Belova	tell-if-ai	36	7	1	2	1	1	0
1794	Anton Muratov	supafax	35	71	1	1	1	0	0
1795	Pankaj Mishra	terrain	36	71	1	2	1	1	0
1796	Christian Timmerer	bitmovin	26	71	1	2	1	1	0
1797	Obinna Akahara	beacon-health	35	71	1	2	1	1	0
1798	Jay Kwon	scoop	36	71	1	1	1	0	0
1799	Hau Chu	unifold	35	57	1	1	1	0	0
1800	Jacob DeWitte	oklo	6	71	3	1	1	0	0
1801	Gavin Brennen	lance	35	71	1	2	1	1	0
1802	Sergey Bunas	21st	35	71	1	2	1	1	0
1803	Corvera	corvera	35	71	1	4	4	0	0
1804	Gabriel Dymowski	pocket	35	71	1	2	1	1	0
1805	Haithem Kchaou	callab-ai	34	71	1	2	1	1	0
1806	Huzaifa Ahmad	hex-security	35	71	1	2	1	1	0
1807	Zeeshan Ahmed	clara-2	34	71	1	1	1	0	0
1808	Ryan Sutton-Gee	plangrid	10	71	2	1	1	0	0
1809	Jason Boehmig	ironclad	26	71	1	2	1	1	0
1810	Vivek Ravisankar	hackerrank	16	71	1	1	1	0	0
1811	Christopher Davlantes	reach	26	71	1	1	1	0	0
1812	Anya Singh	relling	37	71	1	1	1	0	0
1813	Christopher Kong	corvera	35	71	1	2	1	1	0
1814	Ajay Misra FounderCo-founder of o11. Enjoys training models.	o11	35	71	1	2	1	1	0
1815	Steven Xu	greypoint-industries	31	71	1	1	1	0	0
1816	Thomas Aubry Founder - CTOFounder CTO at OoakData.	ooak-data	31	63	1	2	1	1	0
1817	Thesis	thesis	36	71	1	1	0	0	1
1818	BinBin He	smol-machines	34	71	1	2	1	1	0
1819	Matthew Moore	milliray	35	47	1	1	1	0	0
1820	Deokhaeng Lee FounderCS @ Duke	char	37	71	1	2	1	1	0
1821	Leo Schuhmann FounderHelping enterprises win across markets.	complydo	36	12	1	1	1	0	0
1822	Suhail Parry	lunabill	36	71	1	2	1	1	0
1823	Waqas Ali	markhor	26	71	1	2	1	1	0
1824	Yafet Melake	expanse	34	71	1	2	1	1	0
1825	Ryan Xie	origami-robotics	35	71	1	1	1	0	0
1826	Vlad Magdalin	webflow	1	71	1	2	1	1	0
1827	Malhar Bhide	origin-bio	35	71	1	2	1	1	0
1828	Matthew Asir	legalos	35	71	1	2	1	1	0
1829	Zaky Hassan	molagri	31	83	1	1	1	0	0
1830	Bishal Karmakar	projectx	34	71	1	2	1	1	0
1831	Modern	modern	34	71	1	2	2	0	0
1832	Julien Catonnet	klaimee	34	71	1	1	1	0	0
1833	Aydin Sorensen	florin	31	71	1	2	1	1	0
1834	Paola Martinez	cofia	35	57	1	2	1	1	0
1835	Chasi	chasi	35	71	1	2	2	0	0
1836	Zack Leman Co-Founder & CTOCo-Founder & CTO at Jarmin.ai	jarmin	36	71	1	2	1	1	0
1837	Ajay Misra	o11	35	71	1	2	1	1	0
1838	Parker Jenkins	adialante	34	71	1	1	1	0	0
1839	Dmytro Zaporozhets	gitlab	7	71	3	2	1	1	0
1840	Gabriele Pozzato	iron-grid	37	71	1	1	1	0	0
1841	Logical	logical	36	71	1	2	2	0	0
1842	Emmett Bicker	asterlab	34	71	1	1	1	0	0
1843	Whitespace	whitespace	31	47	1	2	2	0	0
1844	Andrew Tran	alkera-ai	31	71	1	1	1	0	0
1845	Markus Skagemo	crunched	36	61	1	1	1	0	0
1846	Chang Lu	insurf	31	71	1	1	1	0	0
1847	Joseph Stein	veritus	37	71	1	2	1	1	0
1848	Ethan Byrd	primitive	34	71	1	2	1	1	0
1849	Harish Ashok	markov	31	71	1	2	1	1	0
1850	Christine Park	lattice-health	34	71	1	2	1	1	0
1851	Jorge Padilla Perez	mango-medical-inc	35	\N	1	2	1	1	0
1852	Andriy Klen	petcube	15	71	1	2	1	1	0
1853	Apollo Atomics, Inc.	apollo-atomics-inc	34	15	1	2	2	0	0
1854	Vineet Singal	caremessage	12	7	1	2	1	1	0
1855	Lewis Blackwood	rex-inc	31	47	1	1	1	0	0
1856	Michael Gonzalez	palus-finance	35	\N	1	2	1	1	0
1857	Michael M	fenrock-ai	35	71	1	1	1	0	0
1858	Pulkit Gupta	tsenta	31	71	1	2	1	1	0
1859	Krish Iyengar	pixley-ai	36	49	1	2	1	1	0
1860	Milan Bhandari	carson	35	71	1	1	1	0	0
1861	Andrew Sy	polymorph	35	71	1	1	1	0	0
1862	Akshay Trikha	madrone	34	71	1	1	1	0	0
1863	Brian Armstrong	coinbase	3	49	3	2	1	1	0
1864	Vivek Nair	multifactor	36	71	1	1	1	0	0
1865	Arihan Varanasi	wato	34	71	1	2	1	1	0
1866	Michael Jeffords	conifer	31	71	1	2	1	1	0
1867	Arash Barati	plan0-ai	34	\N	1	1	1	0	0
1868	Mark Datta	tab	7	47	1	1	1	0	0
1869	Bryant Le	fernstone	36	57	1	1	1	0	0
1870	Chris Pihl	helion-energy	6	72	1	1	1	0	0
1871	Vlad Baskakov	voygr	35	71	1	1	1	0	0
1872	Nerviom	nerviom	36	71	1	2	1	1	0
1873	Akira Tong FounderCo-founder, CTO @ Arga Labs	arga-labs	34	71	1	2	1	1	0
1874	Squid	squid	35	47	1	2	2	0	0
1875	Arseniy Shishaev	superlog	34	71	1	2	1	1	0
1876	Michael Klikushin	solbrowser	36	71	1	2	1	1	0
1877	Anshul Paul	baseframe	35	71	1	1	1	0	0
1878	Hyungseok (Dino) Ha	mbx	12	71	1	1	1	0	0
1879	Christian Pickett	orthogonal	35	71	1	2	1	1	0
1880	Thomas Aubry	ooak-data	31	63	1	2	1	1	0
1881	Victor Chapman	usenarrative	36	71	1	1	1	0	0
1882	Jan Sahagun	trellistech	34	71	1	1	1	0	0
1883	Darcy Zhang	greypoint-industries	31	71	1	1	1	0	0
1884	Gregory Koberger	readme	7	57	1	1	1	0	0
1885	Samuel Clay	newsblur	3	71	1	1	0	1	0
1886	Murtaza Saadat	hyperpad	6	48	1	1	1	0	0
1887	Avyay Varadarajan	daridev	36	71	1	2	1	1	0
1888	Rhea Malhotra	kita	35	71	1	2	1	1	0
1889	Theo Kitsberg	tryprism	34	47	1	1	1	0	0
1890	Witold de La Chapelle	standout	34	71	1	1	1	0	0
1891	Ronan Nopp	voltair	35	71	1	1	1	0	0
1892	Kiran Mohan	lexi	36	71	1	2	1	1	0
1893	Anish Mariathasan	osseus	31	\N	1	1	1	0	0
1894	Austin Stone Founder/CEOFounder and CEO	tell-if-ai	36	7	1	1	1	0	0
1895	Nessie	nessie	36	71	1	2	2	0	0
1896	/dev/fast	carson	35	71	1	1	0	1	0
1897	Alexzendor Misra	shofo	35	71	1	2	1	1	0
1898	Andrew Mello	dispatch	34	71	1	1	1	0	0
1899	Andre von Houck	pushbullet	12	71	1	1	1	0	0
1900	Vishvam Rawal	prana-health	35	71	1	1	1	0	0
1901	Kareem Selim	raspire	34	71	1	1	1	0	0
1902	Jared Houghton	ambition	12	21	1	2	1	1	0
1903	Ansh Sheth	geo-ai	37	57	1	2	1	1	0
1904	Juberth Rodriguez	dialogus	31	71	1	1	1	0	0
1905	SF Tensor	sf-tensor	36	\N	1	3	3	0	0
1906	William Namgyal	luel	35	71	1	1	1	0	0
1907	Arthur De Los Santos	rindler	31	15	1	2	1	1	0
1908	Aidan Williams	maquoketa-research	34	71	1	1	1	0	0
1909	Atman Kar	atrisa	34	71	1	1	1	0	0
1910	Ryan Samadi	alt-x	35	49	1	2	1	1	0
1911	Berke Argin	compresr	35	\N	1	1	1	0	0
1912	Mordi Shadpour	uno-wallet	34	71	1	2	1	1	0
1913	Vanessa Torrivilla	goldbelly	19	57	1	1	1	0	0
1914	Don Muir	f2	37	57	1	1	1	0	0
1915	Bron	bron	36	71	1	4	2	2	0
1916	Philip Ho	absurd	36	49	1	2	1	1	0
1917	Dan Morin	shoptiques	10	57	1	1	1	0	0
1918	Kazuma Choji	saffron	34	71	1	1	1	0	0
1919	Benjamin Finch	withai	34	71	1	2	1	1	0
1920	Nanda Guntupalli	taiga	34	71	1	2	1	1	0
1921	Manufact	manufact	37	71	1	1	0	0	1
1922	Michael Royzen	standard-signal	34	57	1	2	1	1	0
1923	Alexis Aftalion FounderCo-Founder & CEO @ Standout.	standout	34	71	1	2	1	1	0
1924	Ahmed Al Mudarris	plena-health	34	71	1	1	1	0	0
1925	Hammad Malik	uplift-ai	37	71	1	1	1	0	0
1926	Anto Biosciences	anto-biosciences	36	71	1	2	2	0	0
1927	Vikram Vadrevu	avea-robotics	34	71	1	2	1	1	0
1928	Arthur De Los Santos FounderMIT '26 in CS/AI/ML	rindler	31	15	1	2	1	1	0
1929	Nithik Bala	amulet	31	71	1	2	1	1	0
1930	Chris Eigeland	go1	26	71	1	1	1	0	0
1931	Dylan TEIXEIRA	gojiberry-ai	34	71	1	2	1	1	0
1932	Anton Krutiansky	atlasgrid	36	71	1	1	1	0	0
1933	Alex Forman	parse-bot	36	71	1	2	1	1	0
1934	Khalid Ashmawy	munify	37	66	1	1	1	0	0
1935	Harsh Jain	groww	4	9	3	1	1	0	0
1936	Condor Energy	condor-energy	35	63	1	3	3	0	0
1937	Salesgraph	salesgraph	34	71	1	2	2	0	0
1938	Kazuki Shin	kaigo-health	36	71	1	2	1	1	0
1939	Denis Mars	proxy	5	71	2	2	1	1	0
1940	Joseph Humphreys	eden-robotics	34	71	1	1	1	0	0
1941	Aleks Tomovski	modern	34	71	1	1	1	0	0
1942	Yujian Yao	floot	37	71	1	2	1	1	0
1943	Gunin Gupta FounderCofounder and CBO @ Ritivel.	ritivel	35	71	1	1	1	0	0
1944	Alex Blackwell	zatanna	35	71	1	1	1	0	0
1945	Kyle Vogt	cruise	12	71	2	1	1	0	0
1946	Sid Sijbrandij	gitlab	7	71	3	1	1	0	0
1947	Nolan Rossi	foreman	35	71	1	2	1	1	0
1948	Adi Singh Founderco-founder & ceo @ Ara	ara	34	71	1	2	1	1	0
1949	Aman Agarwal	novaflow	37	71	1	2	1	1	0
1950	Patent Watch	patent-watch	36	83	1	1	1	0	0
1951	Arne Strickmann	emdash	35	71	1	2	1	1	0
1952	Andrew Reiter	10x-science	35	71	1	1	1	0	0
1953	Rohit Sirosh	mimos	37	57	1	1	1	0	0
1954	Ivan Vrkic	celltype	35	57	1	1	1	0	0
1955	Bubble Lab	bubble-lab	35	71	1	2	2	0	0
1956	Parth Badhwar	justinian	31	71	1	2	1	1	0
1957	Michael Wachsman	alt-x	35	49	1	1	1	0	0
1958	Alex Toussaint	tornyol	36	63	1	2	1	1	0
1959	Michael Hodara	kuli	34	71	1	2	1	1	0
1960	Pele Collins	beyond-reach-labs	35	57	1	1	1	0	0
1961	Daniel Kivatinos	drchrono	22	71	2	2	1	1	0
1962	Nami Lindquist	claimglide	35	71	1	1	1	0	0
1963	Nisha Gopal	abinitio-bio	34	15	1	1	1	0	0
1964	Lapis	lapis	36	71	1	2	2	0	0
1965	Tornyol	tornyol	36	63	1	3	2	1	0
1966	Shaurnav Ghosh	assemble	31	71	1	1	1	0	0
1967	Dhenenjay Yadav	axionorbital-space	35	71	1	2	1	1	0
1968	Niek Hogenboom	minimal-ai	37	3	1	1	1	0	0
1969	Adam Regelmann	quartzy	16	71	1	1	1	0	0
1970	Daniel Yanisse	checkr	6	71	1	2	1	1	0
1971	David Shijoon Bae	flowmanual	31	71	1	1	1	0	0
1972	RASPIRE	raspire	34	71	1	2	2	0	0
1973	Daishin Sugano	goat-group	22	49	1	1	1	0	0
1974	Marc Zoghby	bron	36	71	1	2	1	1	0
1975	Yuta Baba FounderCo-Founder of Carrot Labs.	carrot-labs	35	71	1	2	1	1	0
1976	Anas Bouassami	bravi	36	71	1	1	1	0	0
1977	Don Muir FounderCo-Founder / CEO @ F2	f2	37	57	1	1	1	0	0
1978	Osman Siddique	sciloop	36	71	1	2	1	1	0
1979	Jason Wang	truevault	12	71	1	1	1	0	0
1980	Omar Abdelaziz	blue	37	71	1	2	1	1	0
1981	Michael Seleman	shortkit	35	\N	1	1	1	0	0
1982	Ali Tabba	gravy	34	71	1	2	1	1	0
1983	hillclimb	hillclimb	36	71	1	1	0	1	0
1984	Roland Saavedra	markit	36	71	1	1	1	0	0
1985	Sentrial	sentrial	35	71	1	2	2	0	0
1986	Haroon Mokhtarzada	truebill	15	74	2	2	1	1	0
1987	Greg Kamradt	arc-prize-foundation	35	71	1	2	1	1	0
1988	Kevin Yu	savant	34	71	1	1	1	0	0
1989	Christine Watts	oxus	35	71	1	1	1	0	0
1990	Lexi	lexi	36	71	1	2	2	0	0
1991	Taylor Brown	fivetran	19	71	1	1	1	0	0
1992	Miso Labs	miso-labs	34	71	1	1	0	0	1
1993	Neha Suresh	procindex	37	71	1	2	1	1	0
1994	Helton Souza	labdoor	7	71	1	1	1	0	0
1995	Will Weber	humoniq	37	71	1	1	1	0	0
1996	Koby Soto	guesty	12	57	1	2	1	1	0
1997	Yue Dai cofounder ceoCofounder & CEO at Strand AI	strand-ai	35	71	1	1	1	0	0
1998	Ethan Kinnan	sherpa	34	71	1	2	1	1	0
1999	Moody Abdul	klarify	34	71	1	2	1	1	0
2000	Carlos Saavedra	makrwatch	7	57	1	1	1	0	0
2001	Lyem Ningthou	asimov	35	71	1	2	1	1	0
2002	Ben Jacob	zymbly	35	47	1	1	1	0	0
2003	Alexandr Wang	scale-ai	5	71	1	1	1	0	0
2004	Aryan Sawhney	usenarrative	36	71	1	2	1	1	0
2005	Atharva Peshkar	axionorbital-space	35	71	1	2	1	1	0
2006	Jedrzej Blaszyk	eigenpal	35	71	1	2	1	1	0
2007	Angus Muffatti	advanced-metal-research	34	49	1	2	1	1	0
2008	Aakash Mahalingam	canary	35	71	1	2	1	1	0
2009	Oded Falik	strand-ai	35	71	1	2	1	1	0
2010	Namanyay Goel	gigacatalyst	34	71	1	2	1	1	0
2011	Tyler Ma	sellraze	36	71	1	2	1	1	0
2012	Matthew Yekell	incandor	34	71	1	1	1	0	0
2013	Nitish Kovuru	coasty	31	71	1	2	1	1	0
2014	Conor Brennan-Burke	hyperspell	36	71	1	2	1	1	0
2015	Brickwise	brickwise	36	47	1	2	2	0	0
2016	Greg Belote	wefunder	19	71	1	1	1	0	0
2017	Tobiasz Dankiewicz	reebee	1	40	1	1	1	0	0
2018	Pravesh Mansharamani	totalis	34	71	1	2	1	1	0
2019	Shourya Vir Jain	ramain	35	71	1	2	1	1	0
2020	Ray Wang	flick	36	71	1	2	1	1	0
2021	Johann Stürken	andustry	34	71	1	2	1	1	0
2022	Gaurav Paliwal	valctrl	34	57	1	2	1	1	0
2023	Rithvik Chuppala FounderCo-Founder at CLODO	clodo	37	71	1	2	1	1	0
2024	Michael Clark	arctic-health	34	71	1	1	1	0	0
2025	Eduard Piliposyan	modelence	37	71	1	2	1	1	0
2026	Na'ama Moran	cheetah	19	71	1	1	1	0	0
2027	Samay Maini	human-archive	35	71	1	2	1	1	0
2028	Reshma Shetty	ginkgo-bioworks	6	15	3	1	1	0	0
2029	Cayden Liao	veria-labs	36	71	1	2	1	1	0
2030	Mostafa Afr	doomersion	35	71	1	1	1	0	0
2031	Frank Wu	nebula-security	31	86	1	2	1	1	0
2032	Jason Yi	verdant	31	71	1	1	1	0	0
2033	Li-Yao Huang	finaldose	34	47	1	1	1	0	0
2034	Nalu Concepcion	idler	37	71	1	2	1	1	0
2035	Mitch Radhuber	corelayer	35	71	1	2	1	1	0
2036	Mikhail Kokorich	momentus	14	71	3	2	1	1	0
2037	Stavros Filosidis	terminal-use	35	71	1	2	1	1	0
2038	Bora Mutluoglu	reacher	37	71	1	2	1	1	0
2039	Cambree Bernkopf	madethis	36	71	1	2	1	1	0
2040	Sumir Meghani	instawork	26	71	1	1	1	0	0
2041	Jack Bubes	rowflow	37	57	1	1	1	0	0
2042	Samuel Hahn	petrarch	31	71	1	1	1	0	0
2043	Denny Luan	experiment	19	37	1	1	1	0	0
2044	Ishan Bansal	groww	4	9	3	1	1	0	0
2045	David Newell	end-close	35	\N	1	2	1	1	0
2046	Ritesh Patel	buildscience	7	60	1	1	1	0	0
2047	Vivek Shah	simplyinsured	19	71	1	1	1	0	0
2048	Xiaochuan Yu	nebula-security	31	86	1	2	1	1	0
2049	Varun Kandula	kinect	34	71	1	2	1	1	0
2050	Chang Lu FounderCEO at Insurf. Ex Brown BS/MD	insurf	31	71	1	1	1	0	0
2051	Aaron King	snapdocs	12	65	1	1	1	0	0
2052	Aram Aghababyan	atlasgrid	36	71	1	1	1	0	0
2053	Arlo Industries	arlo-industries	34	71	1	1	1	0	0
2054	Tim Spratt	permutive	6	47	1	2	1	1	0
2055	Jason Kraft	magicbus	15	49	1	1	1	0	0
2056	Damian Sowers	level-frames	7	57	1	1	0	1	0
2057	Jason Steinberg	autosana	37	71	1	1	1	0	0
2058	Drew Durbin	sendwave	10	15	2	2	1	1	0
2059	Sanjukta Bhattacharya	atlas-discovery	31	71	1	2	1	1	0
2060	Vladimir de Turckheim	tolmo	34	71	1	2	1	1	0
2061	Charles Forman	omgpop	28	57	2	2	1	1	0
2062	Alexis Aftalion	standout	34	71	1	2	1	1	0
2063	Matt Feury	flock-safety	8	5	1	1	1	0	0
2064	Chris Nolet	button-computer	35	71	1	1	1	0	0
2065	Alejandro Salinas	locata	37	57	1	1	1	0	0
2066	James Emerick	cosmic-robotics	31	71	1	2	1	1	0
2067	Abbas Mehdi	medmonk	10	54	1	1	1	0	0
2068	Adam Ron	soria	34	57	1	1	1	0	0
2069	Dennis Steele FounderCo-founder of Podium	podium	15	44	1	1	1	0	0
2070	Tomer London	gusto	10	71	1	2	1	1	0
2071	Dimittri Choudhury	sonarly	35	71	1	2	1	1	0
2072	Lukas Vollmer	uplane	36	71	1	1	1	0	0
2073	Medha Venkatapathy	trustai	31	71	1	2	1	1	0
2074	Kamran Majid	constellation-space	35	72	1	1	1	0	0
2075	Lukasz Reszczynski	pango	31	78	1	2	1	1	0
2076	Cassidy Dalva	miso-labs	34	71	1	2	1	1	0
2077	Ritesh Malpani	oddpool	34	71	1	2	1	1	0
2078	Ian Cinnamon	immunity-project	12	71	1	1	1	0	0
2079	Hexa	hexa	34	71	1	3	3	0	0
2080	Austin Steed	picktrace	26	49	1	1	1	0	0
2081	Sorena Amini	solva	37	57	1	1	1	0	0
2082	Armature	armature	34	71	1	2	2	0	0
2083	Kemar Newell	flip	7	49	1	1	1	0	0
2084	Neo Wang	valence	35	71	1	1	1	0	0
2085	Jack Collins	ventura	35	71	1	2	1	1	0
2086	Fabian Andersson	tenet-industries	34	71	1	2	1	1	0
2087	Omnara	omnara	37	71	1	1	0	1	0
2088	Arjun Talati	knowlify	37	71	1	2	1	1	0
2089	Zibra Labs	zibra-labs	34	71	1	1	0	0	1
2090	Ning Liang	healthsherpa	3	67	1	1	1	0	0
2091	Alisa Wu	bluma	36	71	1	2	1	1	0
2092	Tri Vu	lumius	34	30	1	1	1	0	0
2093	Saurav Mitra	okibi	37	71	1	2	1	1	0
2094	Pavan Kalyan (a.k.a PK) Tankala	ritivel	35	71	1	2	1	1	0
2095	Brett Hagler	new-story	26	5	1	2	1	1	0
2096	LogosGuard	logosguard	36	71	1	2	2	0	0
2097	Locata	locata	37	57	1	2	2	0	0
2098	Eten Zou	nebula-security	31	86	1	2	1	1	0
2099	Alex Mather	the-athletic	5	71	2	2	1	1	0
2100	Rishi Srihari	opennote	37	71	1	2	1	1	0
2101	Peter Volnov	hevn-inc	34	\N	1	2	1	1	0
2102	Adrian Del Bosque	kimpton-ai	34	71	1	2	1	1	0
2103	Tien Chu	lato	31	71	1	1	1	0	0
2104	Semira Rahemtulla	leaders-in-tech	26	71	1	1	1	0	0
2105	Akash Thakur	procindex	37	71	1	2	1	1	0
2106	Corey Centen	bodyport	26	71	1	1	1	0	0
2107	Phillip Baek	useparrot	34	71	1	1	1	0	0
2108	Jun Park	hillclimb	36	71	1	2	1	1	0
2109	Antonio Chan	sira	37	71	1	1	1	0	0
2110	Prateek Jannu	coasty	31	71	1	2	1	1	0
2111	Jonathan Miranda	compyle	36	71	1	2	1	1	0
2112	Ali Khalatpour	pirislabs	35	71	1	1	1	0	0
2113	Gauri Agarwal FounderCTO, Koyal AI, Audio to Video GenAI	koyal	36	71	1	2	1	1	0
2114	Gabriel Castillo	rote	33	71	1	2	1	1	0
2115	Tony Goss FounderDark Forest, Zupass, US Census Bureau.	idler	37	71	1	2	1	1	0
2116	Johnny Doyle	provenmetal	31	71	1	2	1	1	0
2117	Saurav Kumar	fleetline	37	57	1	2	1	1	0
2118	David de Gruijl	anto-biosciences	36	71	1	1	1	0	0
2119	Bence Redmond	hoplite	31	71	1	2	1	1	0
2120	Nic Chu	greypoint-industries	31	71	1	1	1	0	0
2121	Rafael Ferreira	labdoor	7	71	1	2	1	1	0
2122	Neil Chudleigh	partnerstack	26	83	2	2	1	1	0
2123	Galen Burke	zephyr-fusion	36	69	1	1	1	0	0
2124	Jeffrey Byun	akkari	34	71	1	2	1	1	0
2125	The Context Company	the-context-company	36	71	1	2	2	0	0
2126	Specific	specific	36	78	1	2	2	0	0
2127	Ryan Zhang	pax-historia	35	71	1	1	1	0	0
2128	Siddhant Lad	minro	36	71	1	2	1	1	0
2129	Shalin Shah	hyper-4	34	71	1	2	1	1	0
2130	Garrett Beck	asseta	1	58	1	2	1	1	0
2131	Guido Vilariño	democracy-earth	7	51	1	1	1	0	0
2132	Rhea Karimpanal	burnt	37	71	1	2	1	1	0
2133	Tane Kim	framewise-health	34	71	1	1	1	0	0
2134	Ev Kontsevoy	teleport	26	71	1	2	1	1	0
2135	Kurt Sharma	burt	35	71	1	2	1	1	0
2136	Caleb Chan	lance	35	71	1	2	1	1	0
2137	Yining Zhang	norra	36	71	1	1	1	0	0
2138	Juno	juno-chat	34	71	1	2	2	0	0
2139	Hans Ibarra	dialogus	31	71	1	1	1	0	0
2140	Brian Noguchi	lever	3	71	2	2	1	1	0
\.


--
-- Name: dimbatch_batch_key_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dimbatch_batch_key_seq', 37, true);


--
-- Name: dimindustry_industry_key_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dimindustry_industry_key_seq', 59, true);


--
-- Name: dimlocation_location_key_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dimlocation_location_key_seq', 90, true);


--
-- Name: dimstatus_status_key_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dimstatus_status_key_seq', 4, true);


--
-- Name: factcompany_company_key_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.factcompany_company_key_seq', 995, true);


--
-- Name: factfounder_founder_key_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.factfounder_founder_key_seq', 2140, true);


--
-- Name: bridgecompanyindustry bridgecompanyindustry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bridgecompanyindustry
    ADD CONSTRAINT bridgecompanyindustry_pkey PRIMARY KEY (company_key, industry_key);


--
-- Name: dimbatch dimbatch_batch_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimbatch
    ADD CONSTRAINT dimbatch_batch_id_key UNIQUE (batch_id);


--
-- Name: dimbatch dimbatch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimbatch
    ADD CONSTRAINT dimbatch_pkey PRIMARY KEY (batch_key);


--
-- Name: dimindustry dimindustry_industry_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimindustry
    ADD CONSTRAINT dimindustry_industry_name_key UNIQUE (industry_name);


--
-- Name: dimindustry dimindustry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimindustry
    ADD CONSTRAINT dimindustry_pkey PRIMARY KEY (industry_key);


--
-- Name: dimlocation dimlocation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimlocation
    ADD CONSTRAINT dimlocation_pkey PRIMARY KEY (location_key);


--
-- Name: dimstatus dimstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimstatus
    ADD CONSTRAINT dimstatus_pkey PRIMARY KEY (status_key);


--
-- Name: dimstatus dimstatus_status_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dimstatus
    ADD CONSTRAINT dimstatus_status_name_key UNIQUE (status_name);


--
-- Name: factcompany factcompany_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factcompany
    ADD CONSTRAINT factcompany_pkey PRIMARY KEY (company_key);


--
-- Name: factcompany factcompany_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factcompany
    ADD CONSTRAINT factcompany_slug_key UNIQUE (slug);


--
-- Name: factfounder factfounder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factfounder
    ADD CONSTRAINT factfounder_pkey PRIMARY KEY (founder_key);


--
-- Name: bridgecompanyindustry fk_br_company; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bridgecompanyindustry
    ADD CONSTRAINT fk_br_company FOREIGN KEY (company_key) REFERENCES public.factcompany(company_key) ON DELETE CASCADE;


--
-- Name: bridgecompanyindustry fk_br_industry; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bridgecompanyindustry
    ADD CONSTRAINT fk_br_industry FOREIGN KEY (industry_key) REFERENCES public.dimindustry(industry_key);


--
-- Name: factcompany fk_fc_batch; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factcompany
    ADD CONSTRAINT fk_fc_batch FOREIGN KEY (batch_key) REFERENCES public.dimbatch(batch_key);


--
-- Name: factcompany fk_fc_location; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factcompany
    ADD CONSTRAINT fk_fc_location FOREIGN KEY (location_key) REFERENCES public.dimlocation(location_key);


--
-- Name: factcompany fk_fc_status; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factcompany
    ADD CONSTRAINT fk_fc_status FOREIGN KEY (status_key) REFERENCES public.dimstatus(status_key);


--
-- Name: factfounder fk_ff_batch; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factfounder
    ADD CONSTRAINT fk_ff_batch FOREIGN KEY (batch_key) REFERENCES public.dimbatch(batch_key);


--
-- Name: factfounder fk_ff_location; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factfounder
    ADD CONSTRAINT fk_ff_location FOREIGN KEY (location_key) REFERENCES public.dimlocation(location_key);


--
-- Name: factfounder fk_ff_status; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factfounder
    ADD CONSTRAINT fk_ff_status FOREIGN KEY (status_key) REFERENCES public.dimstatus(status_key);


--
-- PostgreSQL database dump complete
--

\unrestrict 6AWkg7fPsQifnR4hy6tTL05NG3awN0d1pKxoEdgo3BH8Rh8Eby7UhxasxbCIST9

