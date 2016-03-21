<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class DefaultController extends Controller
{
    
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction(Request $request)
    {

        return $this->render('default/index.html.twig', [
             'base_dir' => realpath($this->getParameter('kernel.root_dir').'/..'),
         ]);    

    }

    /**
     * @Route("/html", name="to_html")
     */
    public function toHtmlAction(Request $request)
    {

        return $this->render('default/html.html.php', [
             'base_dir' => realpath($this->getParameter('kernel.root_dir').'/..'),
         ]);    

    }

    /**
     * @Route("/pdf", name="to_pdf")
     */
    public function toPdfAction(Request $request)
    {

        $engine  = $this->container->get('templating');
        $content = $engine->render('default/html.html.php');

        return new Response(
            $this->get('knp_snappy.pdf')->getOutputFromHtml($content, [
                'lowquality'       => false,
                'print-media-type' => false,
                'disable-javascript' => false,
                'encoding'         => 'ISO-8859-1',
               /* 'page-size'        => 'A4',
                'outline-depth'    => 8,*/
                'orientation'      => 'Landscape',
                /*'title'            => 'Titulo',                
                'header-right'     =>'Pág. [page] de [toPage]',
                'header-font-size' => 7                */
                ]),
            200,
            array(
                'Content-Type'        => 'application/pdf',
                'Content-Disposition' => 'attachment; filename="reporte.pdf"'
            )
        );    

    }    

  
}
